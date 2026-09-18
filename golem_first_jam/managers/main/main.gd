extends Node

@export var chicken: Chicken
@export var snake: Snake
@export var crow: Crow

@export var chicken_manager: ChickenManager
@export var snake_manager: SnakeManager
@export var road_manager: RoadManager
@export var pushables_manager: PushablesManager
@export var fade_screen: ColorRect


@onready var road := $Terrain/Road
@onready var pushables := %Pushables

func _ready() -> void:
	SignalBus.game_time_over.connect(restart)
	SignalBus.bell_sequence_completed.connect(show_crow) # TODO Do this in the crow manager

	if chicken_manager and chicken:
		chicken_manager.init(chicken)
	if snake_manager and snake:
		snake_manager.init(snake)
	if road_manager and road:
		road_manager.init(road)
	if fade_screen:
		fade_screen.hide()
	if pushables_manager and pushables:
		pushables_manager.init(pushables)
	if crow:
		crow.hide()
	
	
func restart():
	if fade_screen:
		fade_screen.show()

	await wait(0.5)
	
	get_tree().reload_current_scene()

func wait(seconds: float):
	await get_tree().create_timer(seconds).timeout
	
func show_crow(bell_id: Bell.Id):
	if crow:
		crow.show()
