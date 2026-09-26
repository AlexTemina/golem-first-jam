extends Node

@export var chicken: Chicken
@export var snake: Snake

@export var chicken_manager: ChickenManager
@export var snake_manager: SnakeManager
@export var road_manager: RoadManager
@export var pushables_manager: PushablesManager
@export var pickables_manager: PickablesManager
@export var crows_manager: CrowsManager
@export var bells_manager: BellsManager
@export var chicken_npcs_manager: ChickenNpcsManager
@export var night_sky_manager: NightSkyManager
@export var river_manager: RiverManager
@export var dog_manager: DogManager
@export var fade_screen: ResetScreen
## Children of this folder will be registered 
@export var npcs_container: Node
@export var pause_manager: PauseManager

@onready var canvas := $CanvasLayer
@onready var road := %Road
@onready var pushables := %Pushables

func _ready() -> void:
	SignalBus.game_time_over.connect(restart)
	init()
	
func init():
	init_npcs()
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
	if crows_manager:
		crows_manager.init()	
	if night_sky_manager:
		night_sky_manager.init()
	if dog_manager:
		dog_manager.init()
	if not pause_manager:
		print("WARNING: missing pause manager")
	
func restart():
	chicken.block(chicken.global_position)
	if fade_screen:
		fade_screen.show_screen()

		await wait(2)
		
		chicken.release()
		chicken.go_back_to_spawning_point()
		fade_screen.hide()
		SignalBus.reset_game.emit()
	
func init_npcs():
	if npcs_container == null:
		return

	for child in npcs_container.find_children('*', 'Npc'):
		if child is Npc:
			child.init()		

func wait(seconds: float):
	await get_tree().create_timer(seconds).timeout
