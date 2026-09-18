class_name Chicken extends CharacterBody2D

enum Action {NONE, PECKING, FLYING, LAYING_EGG, SCARED}

const SPRITE_SCALE = 1

const ANIMATIONS = {
	Action.NONE: "idle",
	Action.PECKING: "peck",
	Action.FLYING: "fly",
	Action.LAYING_EGG: "lay_egg",
	Action.SCARED: "move",
}

## In px/s
@export var move_speed: int = 200
## How many times you have to push during the quick press timer to fly (see time_to_quick_push)
@export var pushes_to_fly: int = 3
## Max time you have to quick press in order to fly (s)
@export var time_to_quick_push = 0.5 
## In seconds
@export var time_to_lay_egg: float = 3.0
## Vertical impulse for flying (px/s)
@export var jump_max_impulse: float = 5.0
## Gravity modifier, the higher the more gravity
@export var gravity_factor: float = 0.02

@onready var sprite: AnimatedSprite2D = $Sprite
@onready var hold_button_timer: Timer = $HoldButtonTimer
@onready var quick_press_button_timer: Timer = $QuickPressButtonTimer
@onready var scare_timer: Timer = $ScareTimer

var action: Action
var button_charge: float # When you push repeatedly the button, this float "recharges", allowing you to fly when a threshold is surpassed
var z_velocity: float # For jumping/flying
var z_offset: float # Distance from the floor when flying

func _ready() -> void:
	action = Action.NONE
	quick_press_button_timer.wait_time = time_to_quick_push

# Function to move in 8 directions
func _physics_process(delta: float) -> void:
	var previous_velocity = velocity
	
	manage_velocity(delta)
	
	manage_actions_input(delta)
	
	animate(previous_velocity)
		
	face_move_direction()

	move_and_slide()
	
func manage_velocity(delta: float):
	if action in [Action.LAYING_EGG]:
		velocity = Vector2.ZERO
		return
		
	if is_scared():
		return
		
	if is_flying():
		z_velocity += get_gravity().y * gravity_factor * delta
		z_offset += z_velocity
		if z_offset > 0.0:
			land()
		sprite.offset.y = z_offset
		
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
			action = Action.LAYING_EGG
			sprite.play("lay_egg")

func face_move_direction():
	if is_moving():
		if velocity.x > 0:
			sprite.scale.x = SPRITE_SCALE
		elif velocity.x < 0:
			sprite.scale.x = -SPRITE_SCALE
	z_index = position.y
			
func animate(previous_velocity: Vector2):
	match action:
		Action.NONE:
			if has_started_moving(previous_velocity):
				sprite.play("move")
			elif not is_moving():
				sprite.play("idle")

func peck() -> void:
	set_action(Action.PECKING)
	SignalBus.chicken_pecks.emit(position)
	
func fly() -> void:
	set_action(Action.FLYING)
	z_velocity = -jump_max_impulse
	SignalBus.chicken_flies.emit()
	
func lay_egg() -> void:	
	set_action(Action.NONE)
	SignalBus.lay_egg.emit(position)
	
func set_action(new_action: Action):
	action = new_action
	var animation = ANIMATIONS.get(action)
	if animation != null:
		sprite.play(animation)
		print("Animation: " + animation)
	
func scare():
	if is_scared():
		return
	set_action(Action.SCARED)
	velocity = -velocity
	if z_offset != 0:
		land()
		sprite.offset.y = z_offset
	scare_timer.start()
	
func land():
	z_offset = 0.0
	set_action(Action.NONE)
	SignalBus.chicken_lands.emit()
	
func has_started_moving(previous_velocity: Vector2) -> bool:
	return previous_velocity == Vector2.ZERO and is_moving()
	
func is_moving() -> bool:
	return velocity != Vector2.ZERO
	
func is_flying() -> bool:
	return action == Action.FLYING
	
func is_scared() -> bool:
	return action == Action.SCARED

func _on_sprite_animation_finished() -> void:
	set_action(Action.NONE)

func _on_hold_button_timer_timeout() -> void:
	lay_egg()

func _on_quick_press_button_timer_timeout() -> void:
	button_charge = 0

func _on_scare_timer_timeout() -> void:
	velocity = Vector2.ZERO
	set_action(Action.NONE)
