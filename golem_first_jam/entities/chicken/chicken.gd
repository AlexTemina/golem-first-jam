class_name Chicken extends CharacterBody2D

const MOVE_SPEED = 200

@onready var sprite := $Sprite2D # TODO Replace by animated sprite

# Function to move in 8 directions
func _physics_process(delta: float) -> void:
	# Move in 8 directions
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
		
	face_move_direction()

	move_and_slide()

func face_move_direction():
	sprite.scale.x = sign(velocity.x) if velocity.x != 0 else sprite.scale.x	

func peck() -> void:
	pass
	
func fly() -> void:
	pass
	
func lay_egg() -> void:
	pass
