extends Node2D

@onready var exterior_sprite := $ExteriorSprite

func _ready() -> void:
	exterior_sprite.z_index = global_position.y
