class_name PauseManager extends Node

@export var pause_menu: PauseMenu

func _ready() -> void:
	SignalBus.toggle_game_pause.connect(toggle_game_pause)
	pause_menu.hide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause_button"):
		var is_paused = pause_menu.visible
		toggle_game_pause(!is_paused)

func toggle_game_pause(paused := true):
	pause_menu.visible = paused
	get_tree().paused = paused
