class_name Shed extends Node2D

@onready var roof := $ExteriorSprite

func _on_interior_body_entered(body: Node2D) -> void:
	if body is Chicken:
		show_roof(false)

func _on_interior_body_exited(body: Node2D) -> void:
	if body is Chicken:
		show_roof()

func show_roof(on := true):
	roof.visible = on
