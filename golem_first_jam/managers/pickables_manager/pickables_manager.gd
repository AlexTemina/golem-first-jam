class_name PickablesManager extends Node

@export var pickables_container: Node2D

func _ready() -> void:
	SignalBus.chicken_pecks.connect(on_chicken_pecks)
	
func on_chicken_pecks(chicken: Chicken):
	for child in pickables_container.get_children():
		if child is PickableEntity:
			var pickable_entity: PickableEntity = child
			print('chicken - pickable: ' + str(chicken.position) + ' ' + str(pickable_entity.position))
			if pickable_entity.is_near_character_position(chicken.position):
				pickable_entity.picked = true
				pickable_entity.position = chicken.position + chicken.beak.position
				pickable_entity.reparent(chicken.beak)
