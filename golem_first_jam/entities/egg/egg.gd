class_name Egg extends Node2D

func init(position: Vector2):
	self.position = position
	z_index = position.y

func destroy():
	# TODO Play some animation or sound
	get_parent().remove_child(self)
	queue_free()
