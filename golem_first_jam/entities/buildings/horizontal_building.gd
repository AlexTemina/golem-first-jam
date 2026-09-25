@tool
class_name HorizontalBuilding extends StaticBody2D

enum Type {NORMAL, NORMAL_WITH_GRASS, BRICK}

@export var type: Type:
	set(value):
		type = value
		update_sprite()
		
@onready var sprite := $Sprite
@onready var ladder_block = $LadderBlock

func _ready() -> void:
	update_sprite()
		
func update_sprite():
	if sprite:
		sprite.frame = type

func toggle_ladder_block(on := true):
	ladder_block.disabled = !on
	
func set_below_chicken():
	pass # TODO
