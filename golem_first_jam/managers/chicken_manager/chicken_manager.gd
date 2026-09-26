class_name ChickenManager extends Node

@export var chicken_starting_position: Vector2

@onready var river_tilemap := %TileMapLayerRiver

var chicken: Chicken

func _ready() -> void:
	SignalBus.scare_chicken.connect(scare_chicken)
	SignalBus.toggle_learning_spot.connect(toggle_learning)
	SignalBus.chicken_entered_placeable.connect(_on_chicken_entered_placeable)
	SignalBus.chicken_exited_placeable.connect(_on_chicken_exited_placeable)
	SignalBus.chicken_lays_egg_on_chimney.connect(lay_egg_on_chimney)
	SignalBus.polley_up_activated.connect(move_chicken_with_polley)
	SignalBus.polley_up_deactivated.connect(move_chicken_with_polley)
	
func _process(_delta: float) -> void:
	check_chicken_over_river()
	
func init(t_chicken: Chicken):
	self.chicken = t_chicken
	# self.chicken.position = chicken_starting_position
	
func scare_chicken():
	chicken.scare()

func toggle_learning(on: bool):
	chicken.learning = on

## The chicken rides the polley up and down. For now it just teleports
func move_chicken_with_polley(polley_up: PolleyUp):
	print("Moving chicken with polley up: ", polley_up)
	chicken.global_position = polley_up.get_chicken_position()

func check_chicken_over_river():
	if river_tilemap:
		var atlas = TileMapUtils.get_atlas_at_position(river_tilemap, chicken.global_position)
		chicken.over_water = atlas != null # Maybe more checks required	
		
func _on_chicken_entered_placeable(placeable: Placeable):
	if chicken.current_placeable == null and is_instance_valid(placeable):
		chicken.current_placeable = placeable

func _on_chicken_exited_placeable(placeable: Placeable):
	if chicken.current_placeable == placeable:
		chicken.current_placeable = null
		
func lay_egg_on_chimney():
	chicken.block(chicken.global_position)
	await wait(3)
	chicken.release()
	
func wait(seconds: float):
	await get_tree().create_timer(seconds).timeout
