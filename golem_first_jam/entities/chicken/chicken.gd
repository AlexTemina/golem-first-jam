class_name Chicken extends CharacterBody2D

enum Action {NONE, PECKING, FLYING, LAYING_EGG}

const SPRITE_SCALE = 1

@export var move_speed: int = 200
@export var time_to_lay_egg: float = 3.0

@onready var sprite: AnimatedSprite2D = $Sprite
@onready var button_timer: Timer = $ButtonTimer

var action: Action

func _ready() -> void:
	action = Action.NONE

# Function to move in 8 directions
func _physics_process(delta: float) -> void:
	var previous_velocity = velocity
	
	manage_velocity()
	
	manage_actions_input()
	
	animate(previous_velocity)
		
	face_move_direction()

	move_and_slide()
	
func manage_velocity():
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
		
func manage_actions_input():
	if Input.is_action_just_pressed("a_button"):
		button_timer.start(time_to_lay_egg)
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
	pass
	
func lay_egg() -> void:	
	action = Action.NONE
	SignalBus.lay_egg.emit(position)
	
func has_started_moving(previous_velocity: Vector2) -> bool:
	return previous_velocity == Vector2.ZERO and is_moving()
	
func is_moving() -> bool:
	return velocity != Vector2.ZERO

func _on_sprite_animation_finished() -> void:
	action = Action.NONE
	sprite.play("idle")

func _on_button_timer_timeout() -> void:
	lay_egg()
