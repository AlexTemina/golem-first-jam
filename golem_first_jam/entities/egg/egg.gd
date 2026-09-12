class_name Egg extends Node2D

func init(position: Vector2):
	self.position = position
	z_index = position.y
