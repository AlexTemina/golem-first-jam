class_name PushablesManager extends Node

@onready var pushables_container := $Pushables

func _ready() -> void:
	SignalBus.chicken_pecks.connect(on_chicken_pecks)
	
func on_chicken_pecks(chicken_position: Vector2):
	for child in pushables_container.get_children():
		var pushable: PushableEntity = child
		if pushable.is_near_character_position(chicken_position):
			pushable.interact()
