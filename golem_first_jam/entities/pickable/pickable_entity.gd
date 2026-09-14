class_name PickableEntity extends Node2D

func _ready() -> void:
	init(self.position)

func init(position: Vector2):
	self.position = position
	z_index = position.y
