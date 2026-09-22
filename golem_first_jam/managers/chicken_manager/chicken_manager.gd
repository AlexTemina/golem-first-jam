class_name ChickenManager extends Node

@export var chicken_starting_position: Vector2

@onready var river_tilemap := %TileMapLayerRiver

var chicken: Chicken

func _ready() -> void:
	SignalBus.scare_chicken.connect(scare_chicken)
	SignalBus.toggle_learning_spot.connect(toggle_learning)
	
func _process(delta: float) -> void:
	check_chicken_over_river()
	
func init(chicken: Chicken):
	self.chicken = chicken
	self.chicken.position = chicken_starting_position
	
func scare_chicken():
	chicken.scare()

func toggle_learning(on: bool):
	chicken.learning = on

func check_chicken_over_river():
	if river_tilemap:
		var atlas = TileMapUtils.get_atlas_at_position(river_tilemap, chicken.global_position)
		chicken.over_water = atlas != null # Maybe more checks required	
		
	
