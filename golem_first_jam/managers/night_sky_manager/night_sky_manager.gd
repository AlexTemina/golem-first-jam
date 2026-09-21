class_name NightSkyManager extends Node

@export var night_scene: PackedScene = load("res://golem_first_jam/entities/night_sky/night_sky.tscn")

var night_sky: NightSky

func _ready() -> void:
	SignalBus.enter_ecstasy.connect(show_night_sky)
	SignalBus.chicken_is_released.connect(hide_night_sky)
	
	night_sky = night_scene.instantiate()
	night_sky.hide()
	SignalBus.add_node_to_canvas.emit(night_sky)
	
func init():
	pass

func show_night_sky():
	night_sky.show()
	night_sky.draw_pictogram(night_sky.vision_pictogram)
	
func hide_night_sky():
	night_sky.hide()
