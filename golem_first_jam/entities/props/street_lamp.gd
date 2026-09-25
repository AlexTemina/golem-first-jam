@tool
class_name StreetLamp extends StaticBody2D

enum SpriteType {WOOD_1, METAL, WOOD_2}

## Sprite for the lamp
@export var sprite_type: SpriteType:
	set(value):
		sprite_type = value
		update_sprite()
## Radius of the light
@export var radius: float = 2.0:
	set(value):
		radius = value
		light.texture_scale = radius

@onready var light := $PointLight2D
@onready var sprite := $Sprite

func _ready() -> void:
	light.texture_scale = radius
	update_sprite()
	
func update_sprite():
	if sprite:
		sprite.frame = sprite_type
