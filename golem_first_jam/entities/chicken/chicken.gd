class_name Chicken extends CharacterBody2D

enum Action {NONE, PECKING, FLYING, LAYING_EGG}

const SPRITE_SCALE = 1

@export var move_speed: int = 200 # px/s
@export var time_to_lay_egg: float = 3.0 # s
@export var jump_max_impulse: float = 5.0 # Vertical impulse for flying (px/s)
@export var gravity_factor: float = 0.02 # Gravity modifier, the higher the more gravity

@onready var sprite: AnimatedSprite2D = $Sprite
@onready var button_timer: Timer = $ButtonTimer

var action: Action
var button_charge: float # When you push repeatedly the button, this float "recharges", allowing you to fly when a threshold is surpassed
var z_velocity: float # For jumping/flying
var z_offset: float # Distance from the floor when flying

func _ready() -> void:
	action = Action.NONE

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
		
	if is_flying():
		z_velocity += get_gravity().y * gravity_factor * delta
		z_offset += z_velocity
		if z_offset > 0.0:
			z_offset = 0.0
			action = Action.NONE
			SignalBus.chicken_lands.emit()
		sprite.offset.y = z_offset
		
	if Input.is_action_pressed("ui_right"):
		velocity.x = move_speed
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -move_speed
	else:
		velocity.x = 0
	if Input.is_action_pressed("ui_down"):
		velocity.y = move_speed
	elif Input.is_action_pressed("ui_up"):
		velocity.y = -move_speed
	else:
		velocity.y = 0
		
func manage_actions_input(delta: float):	
	if is_flying():	
		return
	
	button_charge = clampf(button_charge - delta, 0, 10)	
	if Input.is_action_just_pressed("a_button"):
		button_timer.start(time_to_lay_egg)
		button_charge += 0.5
		if button_charge > 1.0:			
			fly()
			button_charge = 0.0
			button_timer.stop()
		else:
			peck()	
	elif Input.is_action_just_released("a_button"):
		action = Action.NONE
		button_timer.stop()
		
	if not button_timer.is_stopped() and button_timer.time_left < time_to_lay_egg / 2.0:
		if not action == Action.LAYING_EGG:
			action = Action.LAYING_EGG

func face_move_direction():
	if is_moving():
		if velocity.x > 0:
			sprite.scale.x = SPRITE_SCALE
		elif velocity.x < 0:
			sprite.scale.x = -SPRITE_SCALE
	z_index = position.y
			
func animate(previous_velocity: Vector2):
	match action:
		Action.PECKING:
			sprite.play("peck")
		Action.FLYING:
			sprite.play("fly")
		Action.LAYING_EGG:
			sprite.play("lay_egg")
		Action.NONE:
			if has_started_moving(previous_velocity):
				sprite.play("move")
			elif not is_moving():
				sprite.play("idle")

func peck() -> void:
	action = Action.PECKING
	
func fly() -> void:
	action = Action.FLYING
	z_velocity = -lerp(0.1, jump_max_impulse, button_charge - 0.3)
	SignalBus.chicken_flies.emit()
	
func lay_egg() -> void:	
	action = Action.NONE
	SignalBus.lay_egg.emit(position)
	
func has_started_moving(previous_velocity: Vector2) -> bool:
	return previous_velocity == Vector2.ZERO and is_moving()
	
func is_moving() -> bool:
	return velocity != Vector2.ZERO
	
func is_flying() -> bool:
	return action == Action.FLYING

func _on_sprite_animation_finished() -> void:
	action = Action.NONE
	sprite.play("idle")

func _on_button_timer_timeout() -> void:
	lay_egg()
