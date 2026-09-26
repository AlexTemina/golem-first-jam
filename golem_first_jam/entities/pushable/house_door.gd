@tool
class_name HouseDoor extends PushableEntity

@export var is_open: bool = true:
	set(value):
		is_open = value
		update_sprite()

@export var opens_to_right: bool = false:
	set(value):
		opens_to_right = value
		update_sprite()

@onready var sprite := $Sprite

func _ready() -> void:
	if opens_to_right:
		scale.x = -1

func update_sprite():
	scale.x = -1 if opens_to_right else 1
	if sprite:
		sprite.frame = 0 if is_open else 1
