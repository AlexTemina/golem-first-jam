class_name PushablesManager extends Node

var pushables: Array[PushableEntity] = []
var pushables_container: Node2D # To be replaced by a registry system

func _ready() -> void:
	SignalBus.register_pushable.connect(on_register_pushable)
	SignalBus.chicken_pecks.connect(on_chicken_pecks)
	
func init(pushables: Node2D):
	pushables_container = pushables
	
func on_register_pushable(pushable: PushableEntity):
	pushables.append(pushable)
	
func on_chicken_pecks(chicken: Chicken):	
	for child in pushables:
		var pushable: PushableEntity = child
		if not pushable.pushable_by_chicken:
			continue
		if pushable.is_near_character_position(chicken.global_position):
			pushable.interact()

func get_all_pushables() -> Array:
	var all_pushables = []
	all_pushables.append_array(pushables)
	all_pushables.append_array(pushables_container.get_children())
	return all_pushables
