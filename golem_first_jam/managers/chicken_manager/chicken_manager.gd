class_name ChickenManager extends Node

@export var chicken_starting_position: Vector2

@onready var river_tilemap := %TileMapLayerRiver

var chicken: Chicken

func _ready() -> void:
	SignalBus.scare_chicken.connect(scare_chicken)
	SignalBus.toggle_learning_spot.connect(toggle_learning)
	SignalBus.chicken_entered_placeable.connect(_on_chicken_entered_placeable)
	SignalBus.chicken_exited_placeable.connect(_on_chicken_exited_placeable)
	SignalBus.chicken_uses_chimney.connect(lay_egg_on_chimney)
	
func _process(_delta: float) -> void:
	check_chicken_over_river()
	
func init(t_chicken: Chicken):
	self.chicken = t_chicken
	self.chicken.position = chicken_starting_position
	
func scare_chicken():
	chicken.scare()

func toggle_learning(on: bool):
	chicken.learning = on

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
		
func lay_egg_on_chimney(chimney_target: Vector2):
	chicken.abort_egg()
	chicken.block(chicken.global_position)
	chicken.move_to(chimney_target)
	await wait(2)
	# chicken.lay_egg()
	SignalBus.chicken_lays_egg_on_chimney.emit()
	await wait(1)
	chicken.move_to(chicken.release_position)
	await wait(0.5)
	chicken.release()
	
func wait(seconds: float):
	await get_tree().create_timer(seconds).timeout
