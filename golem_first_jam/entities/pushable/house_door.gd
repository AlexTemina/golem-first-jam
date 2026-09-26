@tool
class_name HouseDoor extends PushableEntity

@onready var open_collision := $OpenCollision
@onready var closed_collision := $ClosedCollision
@onready var door_sound := $DoorSound

@export var is_open: bool = true:
	set(value):
		is_open = value
		update_state()

@export var opens_to_right: bool = false:
	set(value):
		opens_to_right = value
		update_state()

@onready var sprite := $Sprite

func _ready() -> void:
	update_state()

func open():
	door_sound.play()
	is_open = true
	update_state()
	
func update_state():	
	if sprite: # Only if nodes ready
		scale.x = -1 if opens_to_right else 1
		sprite.frame = 0 if is_open else 1
		open_collision.disabled = !is_open
		closed_collision.disabled = is_open
