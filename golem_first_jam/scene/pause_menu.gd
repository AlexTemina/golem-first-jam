class_name PauseMenu extends Node2D

func _on_close_button_pressed() -> void:
	hide()

func _on_sound_slider_value_changed(value: float) -> void:
	SignalBus.set_sounds_volume.emit(value)

func _on_music_slider_value_changed(value: float) -> void:
	SignalBus.set_music_volume.emit(value)
