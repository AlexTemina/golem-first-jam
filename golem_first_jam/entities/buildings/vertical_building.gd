@tool
class_name VerticalBuilding extends StaticBody2D

enum Type {WITH_HOLE, NORMAL}

@export var type: Type:
	set(value):
		type = value
		update_sprite()
		
@onready var sprite := $Sprite

func _ready() -> void:
	update_sprite()
		
func update_sprite():
	if sprite:
		sprite.frame = type
