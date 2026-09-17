extends Node2D

@onready var chicken := $Chicken
@onready var snake := $NPC/Snake
@onready var crow := $NPC/Crow

@onready var chicken_manager := $Managers/ChickenManager
@onready var snake_manager := $Managers/SnakeManager
@onready var road_manager := $Managers/RoadManager
@onready var fade_screen := $CanvasLayer/Fade

@onready var road := $Terrain/Road

func _ready() -> void:
	SignalBus.game_time_over.connect(restart)
	SignalBus.bell_sequence_completed.connect(show_crow) # TODO Do this in the crow manager
	
	chicken_manager.init(chicken)
	snake_manager.init(snake)
	road_manager.init(road)
	crow.hide()
	
	
func restart():
	fade_screen.show()
	await wait(0.5)
	
	get_tree().reload_current_scene()

func wait(seconds: float):
	await get_tree().create_timer(seconds).timeout
	
func show_crow(bell_id: Bell.Id):
	crow.show()
