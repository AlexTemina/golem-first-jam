class_name Tractor extends Node2D

func _ready() -> void:
	init()

func init():
	z_index = position.y
