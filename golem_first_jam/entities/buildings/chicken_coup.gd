@tool
class_name ChickenCoup extends Node2D

@export var roof_visible := true:
	set(value):
		roof_visible = value
		_apply_roof_visibility()

@onready var interior_sprite := $InteriorSprite
@onready var roof := $ExteriorSprite
@onready var animator := $Animator
@onready var chicken_npcs_container := $Chickens

var door_opened:= false

func _ready() -> void:
	SignalBus.chicken_coup_door_opened.connect(func(): door_opened = true)
	_apply_roof_visibility()	
	init()
	
func init():
	for chicken in chicken_npcs_container.get_children():
		if chicken is ChickenNpc:
			chicken.init()

func _on_interior_body_entered(body: Node2D) -> void:
	if body is Chicken:
		show_roof(false)

func _on_interior_body_exited(body: Node2D) -> void:
	if body is Chicken:
		show_roof()

func show_roof(on := true):
	if not door_opened:
		return
	roof_visible = on
	animator.play("show_roof" if on else "hide_roof")

func _apply_roof_visibility() -> void:
	var sprite := get_node_or_null(^"ExteriorSprite") as Sprite2D
	if sprite == null:
		return
	# sprite.visible = roof_visible
	sprite.modulate.a = 1.0 if roof_visible else 0.0
