class_name PushablesManager extends Node

var pushables: Array[PushableEntity] = []
var pushables_container: Node2D # To be replaced by a registry system

func _ready() -> void:
	SignalBus.register_pushable.connect(on_register_pushable)
	SignalBus.chicken_tries_interaction.connect(on_chicken_tries_interaction)
	
func init(t_pushables_container: Node2D):
	pushables_container = t_pushables_container
	
func on_register_pushable(pushable: PushableEntity):
	pushables.append(pushable)
	
func on_chicken_tries_interaction(chicken: Chicken):
	var interacted := false
	for child in pushables:
		var pushable: PushableEntity = child
		if not pushable.pushable_by_chicken or not pushable.is_interactable():
			continue
		if pushable.is_near_character_position(chicken.global_position):
			pushable.interact(chicken)
			interacted = true
	if interacted:
		SignalBus.chicken_interacted.emit(chicken)

func get_all_pushables() -> Array:
	var all_pushables = []
	all_pushables.append_array(pushables)
	all_pushables.append_array(pushables_container.get_children())
	return all_pushables
