class_name PickablesManager extends Node

@export var pickables_container: Node2D

var picked_entity: PickableEntity

func _ready() -> void:
	SignalBus.chicken_pecks.connect(on_chicken_pecks)
	
func on_chicken_pecks(chicken: Chicken):
	if picked_entity != null:
		drop_item()
	else:
		for child in pickables_container.get_children():
			if child is PickableEntity:
				var pickable_entity: PickableEntity = child
				if pickable_entity.is_near_character_position(chicken.position):
					pick_up_item(chicken, pickable_entity)
					
func pick_up_item(chicken: Chicken, item: PickableEntity):
	picked_entity = item
	item.picked = true
	item.position = chicken.position + chicken.beak.position
	item.reparent(chicken.beak)

func drop_item():
	picked_entity.reparent(pickables_container)
	picked_entity.position.y += 14 # Fall from beak
	picked_entity = null
