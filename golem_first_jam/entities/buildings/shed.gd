class_name Shed extends Node2D

@onready var roof := $ExteriorSprite
@onready var animator := $Animator

func _on_interior_body_entered(body: Node2D) -> void:
	if body is Chicken:
		show_roof(false)

func _on_interior_body_exited(body: Node2D) -> void:
	if body is Chicken:
		show_roof()

func show_roof(on := true):
	if on:
		animator.play("show_roof")
	else:
		animator.play("hide_roof")
