class_name PickablesManager extends Node

## When you drop an item, it reparents to this container
@export var pickables_container: Node2D

var pickables: Array[PickableEntity] = []

var picked_entity: PickableEntity

func _ready() -> void:
	SignalBus.register_pickable.connect(register_pickable)
	SignalBus.unregister_pickable.connect(unregister_pickable)
	SignalBus.chicken_pecks.connect(on_chicken_pecks)
	SignalBus.give_item_to_chicken.connect(pick_up_item)
	SignalBus.take_item_from_chicken.connect(drop_item)
	
func register_pickable(pickable: PickableEntity):
	pickables.append(pickable)

func unregister_pickable(pickable: PickableEntity):
	pickables.erase(pickable)
	if picked_entity == pickable:
		picked_entity = null

func on_chicken_pecks(chicken: Chicken):
	if _is_pickable_available(picked_entity):
		drop_item(chicken)
	else:
		var near_pickable_index = pickables.find_custom(_pickable_is_near_character_position.bind(chicken.position))
		if near_pickable_index != -1:
			var near_pickable = pickables[near_pickable_index]
			pick_up_item(chicken, near_pickable)
		else:
			SignalBus.chicken_pecks_nothing.emit(chicken)

func _is_pickable_available(pickable: Variant) -> bool:
	return is_instance_valid(pickable) && !pickable.is_queued_for_deletion()

func _pickable_is_near_character_position(pickable: Variant, character_position: Vector2) -> bool:
	return _is_pickable_available(pickable) && !pickable.placed && pickable.is_near_character_position(character_position)

func pick_up_item(chicken: Chicken, item: PickableEntity):
	picked_entity = item
	item.picked = true
	item.reparent(pickables_container)
	item.position = chicken.position + chicken.get_beak_position()
	item.reparent(chicken.beak)
	# TODO Fix z-index

func drop_item(chicken: Chicken):
	var item := picked_entity
	picked_entity = null

	# Someone else (a door, for instance) may take the item instead of letting it fall
	SignalBus.chicken_drops_item.emit(chicken, item)
	if item.placed:
		return

	item.reparent(pickables_container)
	item.position.y += 14 # Fall from beak
	SignalBus.play_item_sound.emit(SoundManager.ItemSound.DROP)
