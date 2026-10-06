class_name NightSkyManager extends Node

@export var night_scene: PackedScene = load("res://golem_first_jam/entities/night_sky/night_sky.tscn")
@export var canvas_layer: CanvasLayer

var night_sky: NightSky
var help_text := ''

func _ready() -> void:
	SignalBus.toggle_learning_spot.connect(update_help_text)
	SignalBus.enter_ecstasy.connect(show_night_sky)
	SignalBus.chicken_is_released.connect(hide_night_sky)

	night_sky = night_scene.instantiate()
	night_sky.hide()
	canvas_layer.add_child(night_sky)
	
func init():
	pass
	
func update_help_text(on: bool, new_help_text: String):
	help_text = new_help_text

func show_night_sky():
	night_sky.show()
	night_sky.clear_stars()
	night_sky.draw_text_stars(help_text)
	#night_sky.draw_pictogram(night_sky.vision_pictogram_q)
	#night_sky.draw_pictogram(night_sky.vision_pictogram_e)
	
func hide_night_sky():
	night_sky.hide()
