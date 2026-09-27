class_name PauseMenu extends Node2D

@onready var sound_slider := $TextureRect/SoundSlider
@onready var music_slider := $TextureRect/MusicSlider

func _ready() -> void:
	pass
	
func init():
	sound_slider.set_value_no_signal(SoundConfig.effects_volume)
	music_slider.set_value_no_signal(SoundConfig.music_volume)

func _on_close_button_pressed() -> void:
	SignalBus.toggle_game_pause.emit(false)

func _on_sound_slider_value_changed(value: float) -> void:
	SignalBus.set_sounds_volume.emit(value)

func _on_music_slider_value_changed(value: float) -> void:
	SignalBus.set_music_volume.emit(value)
