@tool
class_name StreetLamp extends StaticBody2D

## Radius of the light
@export var radius: float = 2.0:
	set(value):
		radius = value
		light.texture_scale = radius

@onready var light := $PointLight2D

func _ready() -> void:
	z_index = global_position.y
	light.texture_scale = radius
