class_name SpecialVisionManager extends Node2D

@onready var canvas_modulate := $CanvasModulate
@onready var shader_rectangle := $ShaderCanvasLayer/ColorRect

func _ready() -> void:
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("b_button"):
		toggle_vision()
		
func toggle_vision():
	var on = !canvas_modulate.visible
	canvas_modulate.visible = on
	shader_rectangle.visible = on
	SignalBus.special_vision_toggled.emit(on)
	
