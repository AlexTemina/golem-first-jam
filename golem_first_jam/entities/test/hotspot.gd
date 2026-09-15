class_name Hotspot extends Node2D

@onready var rectangle := $ColorRect

func _ready() -> void:
	SignalBus.special_vision_toggled.connect(toggle)
	
	rectangle.color = Color.WHEAT
	toggle(false)

func toggle(on := true):
	rectangle.visible = on
