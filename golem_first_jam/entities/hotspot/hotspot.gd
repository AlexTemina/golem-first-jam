class_name Hotspot extends Node2D

@onready var polygon_2d: Polygon2D = $Polygon2D

func _ready() -> void:
	SignalBus.special_vision_toggled.connect(toggle)
	
	polygon_2d.color = Color.WHEAT
	toggle(false)

func toggle(on := true):
	polygon_2d.visible = on

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent() is Egg:
		SignalBus.egg_in_hotspot.emit(area.get_parent())
