class_name NightVision extends Node2D

## Seconds of continuous use until the noise makes the vision unusable
@export var noise_time_to_max := 60.0
## Seconds turned off to fully recover from max noise
@export var noise_recovery_time := 30.0
## Shape of the noise ramp: < 1 grows fast early, 1 = linear, > 1 = late
@export var noise_curve := 0.7

@onready var mesh_instance := $MeshInstance2D

var shader_time: float
## Noise buildup, 0 = clean, 1 = unusable. Grows while on, recovers while off.
var noise_level := 0.0

func toggle(on := true):
	visible = on
	shader_time = 0.0

func _process(delta: float) -> void:
	if visible:
		shader_time += delta
		noise_level = minf(noise_level + delta / noise_time_to_max, 1.0)
		mesh_instance.material.set_shader_parameter("shader_time", shader_time)
		mesh_instance.material.set_shader_parameter("noise_level", pow(noise_level, noise_curve))
	else:
		noise_level = maxf(noise_level - delta / noise_recovery_time, 0.0)
