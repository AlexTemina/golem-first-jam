class_name PauseMenu extends Node2D

@onready var sound_slider := $ColorRect/SoundSlider
@onready var music_slider := $ColorRect/MusicSlider

func _ready() -> void:
	pass
	
func init():
	SignalBus.set_sounds_volume.emit(sound_slider.value)
	SignalBus.set_music_volume.emit(music_slider.value)

func _on_close_button_pressed() -> void:
	SignalBus.toggle_game_pause.emit(false)

func _on_sound_slider_value_changed(value: float) -> void:
	SignalBus.set_sounds_volume.emit(value)

func _on_music_slider_value_changed(value: float) -> void:
	SignalBus.set_music_volume.emit(value)
