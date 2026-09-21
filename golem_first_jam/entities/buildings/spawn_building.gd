@tool
class_name SpawnBuilding extends Node2D

@export var roof_visible := true:
	set(value):
		roof_visible = value
		_apply_roof_visibility()

@onready var interior_sprite := $InteriorSprite
@onready var roof := $ExteriorSprite
@onready var exterior_wall := $ExteriorWallSprite
@onready var animator := $Animator
@onready var jail_door := $JailDoor

func _ready() -> void:
	_apply_roof_visibility()	
	interior_sprite.z_index = interior_sprite.position.y
	# roof.z_index = interior_sprite.z_index + 1
	# exterior_wall.z_index = interior_sprite.z_index + 1
	jail_door.z_index = position.y - 24

func _on_interior_body_entered(body: Node2D) -> void:
	if body is Chicken:
		show_roof(false)

func _on_interior_body_exited(body: Node2D) -> void:
	if body is Chicken:
		show_roof()

func show_roof(on := true):
	roof_visible = on
	animator.play("show_roof" if on else "hide_roof")

func _apply_roof_visibility() -> void:
	var sprite := get_node_or_null(^"ExteriorSprite") as Sprite2D
	if sprite == null:
		return
	# sprite.visible = roof_visible
	sprite.modulate.a = 1.0 if roof_visible else 0.0
