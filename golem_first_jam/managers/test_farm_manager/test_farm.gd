extends Node2D

@onready var fade_screen := $CanvasLayer/Fade

@onready var crow := $Crow

func _ready() -> void:
	SignalBus.game_time_over.connect(restart)
	SignalBus.bell_sequence_completed.connect(show_crow) # TODO Do this in the crow manager
	
	crow.hide()
	
func restart():
	fade_screen.show()
	await wait(0.5)
	
	get_tree().reload_current_scene()

func wait(seconds: float):
	await get_tree().create_timer(seconds).timeout
	
func show_crow(bell_id: Bell.Id):
	crow.show()
