class_name PushablesManager extends Node

var pushables_container: Node2D

func _ready() -> void:
	SignalBus.chicken_pecks.connect(on_chicken_pecks)
	
func init(pushables: Node2D):
	pushables_container = pushables
	
func on_chicken_pecks(chicken: Chicken):
	for child in pushables_container.get_children():
		var pushable: PushableEntity = child
		if pushable.is_near_character_position(chicken.position):
			pushable.interact()
