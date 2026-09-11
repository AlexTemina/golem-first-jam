extends Node

@export var camera_target: Node2D

@onready var phantom_camera: PhantomCamera2D = %PhantomCamera2D

func _ready() -> void:
	print(phantom_camera)
	if camera_target != null:
		phantom_camera.follow_target = camera_target
