class_name Chicken extends CharacterBody2D

enum Action {NONE, PECKING, FLYING, LAYING_EGG}

const MOVE_SPEED = 200

const SPRITE_SCALE = 1

@onready var sprite: AnimatedSprite2D = $Sprite

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
		velocity.x = MOVE_SPEED
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -MOVE_SPEED
	else:
		velocity.x = 0	
	if Input.is_action_pressed("ui_down"):
		velocity.y = MOVE_SPEED
	elif Input.is_action_pressed("ui_up"):
		velocity.y = -MOVE_SPEED
	else:
		velocity.y = 0
		
func manage_actions_input():
	if Input.is_action_just_pressed("a_button"):
		peck()	

func face_move_direction():
	if is_moving():
		if velocity.x > 0:
			sprite.scale.x = SPRITE_SCALE
		elif velocity.x < 0:
			sprite.scale.x = -SPRITE_SCALE
			
func animate(previous_velocity: Vector2):
	match action:
		Action.PECKING:
			sprite.play("peck")
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
	pass
	
func has_started_moving(previous_velocity: Vector2) -> bool:
	return previous_velocity == Vector2.ZERO and is_moving()
	
func is_moving() -> bool:
	return velocity != Vector2.ZERO

func _on_sprite_animation_finished() -> void:
	action = Action.NONE
	sprite.play("idle")
