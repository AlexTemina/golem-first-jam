class_name Chicken extends CharacterBody2D

enum Action {NONE, PECKING, FLYING, LAYING_EGG, SCARED, ECSTATIC}

const SPRITE_SCALE = 1

const ANIMATIONS = {
	Action.NONE: "idle",
	Action.PECKING: "peck",
	Action.FLYING: "fly",
	Action.LAYING_EGG: "lay_egg",
	Action.SCARED: "move",
	Action.ECSTATIC: "ecstatic"
}

@export_group("Movement")
## In px/s
@export var move_speed: int = 200
## How many times you have to push during the quick press timer to fly (see time_to_quick_push)
@export var pushes_to_fly: int = 3
## Vertical impulse for flying (px/s)
@export var jump_max_impulse: float = 5.0
## Gravity modifier, the higher the more gravity
@export var gravity_factor: float = 0.02
@export_group("Time stuff")
## Max time you have to quick press in order to fly (s)
@export var time_to_quick_push = 0.5 
## In seconds
@export var time_to_lay_egg: float = 3.0
## Time to enter ecstasy (learn something)
@export var time_to_ecstasy: float = 2.0

@onready var body := $Body
@onready var sprite: AnimatedSprite2D = $Body/Sprite
@onready var beak := $Body/Beak
@onready var wings := $Body/Wings
@onready var hold_button_timer: Timer = $HoldButtonTimer
@onready var quick_press_button_timer: Timer = $QuickPressButtonTimer
@onready var scare_timer: Timer = $ScareTimer
@onready var ecstasy_timer: Timer = $EcstasyTimer

var action: Action
var blocked := false # For some puzzles, keep the chicken blocked
var release_position: Vector2
var button_charge: float # When you push repeatedly the button, this float "recharges", allowing you to fly when a threshold is surpassed
var z_velocity: float # For jumping/flying
var z_offset: float # Distance from the floor when flying
var learning: bool
var over_water: bool

func _ready() -> void:
	action = Action.NONE
	quick_press_button_timer.wait_time = time_to_quick_push
	ecstasy_timer.wait_time = time_to_ecstasy

# Function to move in 8 directions
func _physics_process(delta: float) -> void:
	var previous_velocity = velocity
	
	if blocked:
		manage_blockness()
	else:
		manage_velocity(delta)	
		manage_actions_input(delta)	
		animate(previous_velocity)		
		face_move_direction()
		move_and_slide()
	
func manage_velocity(delta: float):
	if action in [Action.LAYING_EGG] or blocked:
		velocity = Vector2.ZERO
		return
		
	if is_scared():
		return
		
	if is_flying():
		if z_velocity < 0 and over_water: # If falling over water, stop fall
			return
		z_velocity += get_gravity().y * gravity_factor * delta		
		z_offset += z_velocity
		if z_offset > 0.0:
			land()
		body.position.y = z_offset
		
	if Input.is_action_pressed("right"):
		velocity.x = move_speed
	elif Input.is_action_pressed("left"):
		velocity.x = -move_speed
	else:
		velocity.x = 0
	if Input.is_action_pressed("down"):
		velocity.y = move_speed
	elif Input.is_action_pressed("up"):
		velocity.y = -move_speed
	else:
		velocity.y = 0
		
func manage_blockness():
	if Input.is_action_just_pressed("down") or Input.is_action_just_pressed("up"):
		release()
		
func manage_actions_input(delta: float):	
	if is_flying() or is_scared():	
		return
	
	# button_charge = clampf(button_charge - delta, 0, 10)	
	if Input.is_action_just_pressed("a_button"):
		hold_button_timer.start(time_to_lay_egg)
		if quick_press_button_timer.is_stopped():
			quick_press_button_timer.start()
		else:
			button_charge += 1
		if button_charge >= pushes_to_fly:			
			fly()
			button_charge = 0.0
			quick_press_button_timer.stop()
			hold_button_timer.stop()
		else:
			peck()	
	elif Input.is_action_just_released("a_button"):
		hold_button_timer.stop()
		
	if not hold_button_timer.is_stopped() and hold_button_timer.time_left < time_to_lay_egg / 2.0:
		if not action == Action.LAYING_EGG:
			set_action(Action.LAYING_EGG)

func face_move_direction():
	if is_moving():
		if velocity.x > 0:
			face_right(true)
		elif velocity.x < 0:
			face_right(false)
	z_index = position.y
	
func face_right(right := true):
	body.scale.x = SPRITE_SCALE if right else -SPRITE_SCALE
			
func animate(previous_velocity: Vector2):
	match action:
		Action.NONE:
			if has_started_moving(previous_velocity):
				sprite.play("move")
			elif not is_moving():
				sprite.play("idle")
	if learning and action == Action.NONE and has_stopped_moving(previous_velocity):
		ecstasy_timer.start()
		

func peck() -> void:
	set_action(Action.PECKING)
	SignalBus.chicken_pecks.emit(self)
	
func fly() -> void:
	set_action(Action.FLYING)
	wings.show()
	wings.play("default")
	z_velocity = -jump_max_impulse
	z_offset = -0.01
	SignalBus.chicken_flies.emit()
	
func land():
	if over_water:
		print('You landed on water. This is bad.')
	z_offset = 0.0
	body.position.y = z_offset
	wings.hide()
	set_action(Action.NONE)
	SignalBus.chicken_lands.emit()
	
func lay_egg() -> void:	
	set_action(Action.NONE)
	SignalBus.lay_egg.emit(position)
	
func set_action(new_action: Action):
	action = new_action
	var animation = ANIMATIONS.get(action)
	if animation != null:
		sprite.play(animation)
		# print("Animation: " + animation)	
	
func scare():
	if is_scared():
		return
	set_action(Action.SCARED)
	velocity = -velocity
	if z_offset != 0:
		land()
	scare_timer.start()
	
func block(release_position: Vector2, new_action := Action.NONE):
	set_action(new_action)
	blocked = true
	self.release_position = release_position
	
func release():
	blocked = false
	position = release_position
	release_position = Vector2.ZERO
	SignalBus.chicken_is_released.emit()
	
func has_started_moving(previous_velocity: Vector2) -> bool:
	return previous_velocity == Vector2.ZERO and is_moving()
	
func has_stopped_moving(previous_velocity: Vector2) -> bool:
	return previous_velocity != Vector2.ZERO and not is_moving()
	
func is_moving() -> bool: return velocity != Vector2.ZERO	
func is_flying() -> bool: return z_offset < 0.0
func is_scared() -> bool: return action == Action.SCARED
func is_ecstatic() -> bool: return action == Action.ECSTATIC

func get_beak_position() -> Vector2:
	return beak.position if body.scale.x > 0 else Vector2(-beak.position.x, beak.position.y)
	
func get_picked_item():
	return beak.get_child(0) if beak.get_children().size() > 0 else null

func _on_sprite_animation_finished() -> void:
	if learning and is_ecstatic():
		SignalBus.enter_ecstasy.emit()
	set_action(Action.NONE)

func _on_hold_button_timer_timeout() -> void:
	lay_egg()

func _on_quick_press_button_timer_timeout() -> void:
	button_charge = 0

func _on_scare_timer_timeout() -> void:
	velocity = Vector2.ZERO
	set_action(Action.NONE)

func _on_ecstasy_timer_timeout() -> void:
	if learning:
		block(global_position, Action.ECSTATIC)
