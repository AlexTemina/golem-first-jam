class_name NightVision extends Node2D

@onready var mesh_instance := $MeshInstance2D

var shader_time: float

func toggle(on := true):
	visible = on
	shader_time = 0.0

func _process(delta: float) -> void:
	if visible:
		shader_time += delta
		mesh_instance.material.set_shader_parameter("shader_time", shader_time)
	
