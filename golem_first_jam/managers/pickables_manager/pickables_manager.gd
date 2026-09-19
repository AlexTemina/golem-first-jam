class_name PickablesManager extends Node

## When you drop an item, it reparents to this container
@export var pickables_container: Node2D

var pickables: Array[PickableEntity] = []

var picked_entity: PickableEntity

func _ready() -> void:
	SignalBus.register_pickable.connect(register_pickable)
	SignalBus.chicken_pecks.connect(on_chicken_pecks)
	
func register_pickable(pickable: PickableEntity):
	pickables.append(pickable)
	
func on_chicken_pecks(chicken: Chicken):
	if _is_pickable_available(picked_entity):
		drop_item()
	else:
		var near_pickable_index = pickables.find_custom(_pickable_is_near_character_position.bind(chicken.position))
		if near_pickable_index != -1:
			var near_pickable = pickables[near_pickable_index]
			pick_up_item(chicken, near_pickable)

func _is_pickable_available(pickable: Node) -> bool:
	return pickable != null && !pickable.is_queued_for_deletion()

func _pickable_is_near_character_position(pickable: PickableEntity, character_position: Vector2) -> bool:
	return _is_pickable_available(pickable) && pickable.is_near_character_position(character_position)

func pick_up_item(chicken: Chicken, item: PickableEntity):
	picked_entity = item
	item.picked = true
	item.reparent(pickables_container)
	item.position = chicken.position + chicken.get_beak_position()
	item.reparent(chicken.beak)
	# TODO Fix z-index

func drop_item():
	picked_entity.reparent(pickables_container)
	picked_entity.position.y += 14 # Fall from beak
	picked_entity = null
	SignalBus.play_item_sound.emit(SoundManager.ItemSound.DROP)
