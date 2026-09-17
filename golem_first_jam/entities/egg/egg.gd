class_name Egg extends Node2D

@onready var sprite := $Sprite

func init(position: Vector2):
	self.position = position
	z_index = position.y

func break_egg():
	sprite.play("break")

func _on_sprite_animation_finished() -> void:
	destroy()

func destroy():
	get_parent().remove_child(self)
	queue_free()
