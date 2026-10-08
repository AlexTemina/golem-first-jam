@tool
class_name StreetLamp extends StaticBody2D

enum SpriteType {WOOD_1, METAL, WOOD_2}

## Light texture size that radius is measured against (radius 1 = 192px),
## so swapping in a higher-res light texture doesn't change the light size
const RADIUS_BASE_SIZE := 192.0

## Sprite for the lamp
@export var sprite_type: SpriteType:
	set(value):
		sprite_type = value
		update_sprite()
## Radius of the light
@export var radius: float = 2.0:
	set(value):
		radius = value
		update_light()
##Intensity of the light
@export var energy: float = 3.0:
	set(value):
		light.energy = value
		update_light()

@onready var light := $PointLight2D
@onready var sprite := $Sprite

func _ready() -> void:
	update_light()
	update_sprite()

func update_light():
	if light and light.texture:
		light.texture_scale = radius * RADIUS_BASE_SIZE / light.texture.get_width()
	
func update_sprite():
	if sprite:
		sprite.frame = sprite_type
