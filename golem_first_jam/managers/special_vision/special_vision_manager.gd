class_name SpecialVisionManager extends Node

## Container of all the dark zones
@export var dark_zones_container: Node2D
## Canvas modulate
@export var canvas_modulate_darkness: CanvasModulate
## Night vision node
@export var night_vision: NightVision

@onready var canvas_modulate_green := $CanvasModulate
@onready var shader_rectangle := $ShaderCanvasLayer/ColorRect

var on := false

func _ready() -> void:
	pass

func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("a_button") and Input.is_action_pressed("c_button"):
		toggle_vision()
		
func toggle_vision():
	on = !on
	# canvas_modulate_green.visible = on
	night_vision.visible = on
	canvas_modulate_darkness.visible = !on
	#shader_rectangle.visible = on
	SignalBus.special_vision_toggled.emit(on)
	if dark_zones_container:
		dark_zones_container.visible = !on
	
