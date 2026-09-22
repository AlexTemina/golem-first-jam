class_name DogManager extends Node

## Max distance to be attracted to an egg
@export var max_distance_to_egg: int = 200
## Time the dog takes to smell the egg ang go for it
@export var time_to_discover_fried_egg = 3.0

var dog: Dog

func _ready() -> void:
	SignalBus.egg_fried.connect(on_egg_fried)
	SignalBus.register_npc.connect(on_register_npc)
	
func init():
	pass
	
func on_register_npc(npc: Npc):
	if npc is Dog:
		dog = npc
	
func on_egg_fried(egg: Egg):
	await wait(time_to_discover_fried_egg)
	SignalBus.pause_game_time.emit()
	var egg_position = egg.global_position
	var distance_to_egg = egg_position.distance_to(dog.position)
	if distance_to_egg <= max_distance_to_egg:
		dog.go_to_egg(egg_position)

func wait(seconds: float):
	await get_tree().create_timer(seconds).timeout
