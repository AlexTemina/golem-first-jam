class_name Highlight extends Node

## Makes a sprite stand out with a light outline and a pulsing glow.
## Add it as a child of anything that should catch the eye (pickable items, for instance)

const SHADER := preload("res://golem_first_jam/entities/highlight/outline_glow.gdshader")

## The sprite to highlight. If empty, the first Sprite2D sibling
@export var sprite: Sprite2D
@export var outline_color := Color(1.0, 0.95, 0.7)
@export_range(0.0, 1.0) var glow_amount := 0.25
@export var glow_speed := 1.0

var material: ShaderMaterial

func _ready() -> void:
	if sprite == null:
		var sprites := get_parent().find_children("*", "Sprite2D", false)
		sprite = sprites[0] if not sprites.is_empty() else null
	if sprite == null:
		push_warning("Highlight: no sprite to highlight in %s" % get_parent())
		return
	material = ShaderMaterial.new()
	material.shader = SHADER
	material.set_shader_parameter("outline_color", outline_color)
	material.set_shader_parameter("glow_amount", glow_amount)
	material.set_shader_parameter("glow_speed", glow_speed)
	material.set_shader_parameter("region_uv", _region_uv())
	sprite.material = material

func toggle(on := true):
	if sprite:
		sprite.material = material if on else null

func _region_uv() -> Vector4:
	if not sprite.region_enabled or sprite.texture == null:
		return Vector4(0, 0, 1, 1)
	var size := sprite.texture.get_size()
	var r := sprite.region_rect
	return Vector4(r.position.x / size.x, r.position.y / size.y, r.size.x / size.x, r.size.y / size.y)
