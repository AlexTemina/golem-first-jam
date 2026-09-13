extends Node2D

@onready var fade_screen := $CanvasLayer/Fade

func _ready() -> void:
	SignalBus.game_time_over.connect(restart)
	
func restart():
	fade_screen.show()
	await wait(0.5)
	
	get_tree().reload_current_scene()

func wait(seconds: float):
	await get_tree().create_timer(seconds).timeout
