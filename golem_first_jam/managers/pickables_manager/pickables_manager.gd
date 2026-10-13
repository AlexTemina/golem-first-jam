class_name PickablesManager extends Node

## When you drop an item, it reparents to this container
@export var pickables_container: Node2D

var pickables: Array[PickableEntity] = []

var picked_entity: PickableEntity

## Q went down with an item in the beak: it falls when Q goes up
var drop_armed := false
## Something else used this press (an interaction, night vision, an egg), so the item stays in the beak
var drop_cancelled := false
## In ms, to know if a quick press while running ended up being a flight
var last_flight_time := -1

func _ready() -> void:
	SignalBus.register_pickable.connect(register_pickable)
	SignalBus.unregister_pickable.connect(unregister_pickable)
	SignalBus.chicken_pecks.connect(on_chicken_pecks)
	SignalBus.chicken_stops_pecking.connect(on_chicken_stops_pecking)
	SignalBus.chicken_interacted.connect(cancel_drop.unbind(1))
	SignalBus.special_vision_toggled.connect(cancel_drop.unbind(1))
	SignalBus.lay_egg.connect(cancel_drop.unbind(1))
	SignalBus.chicken_flies.connect(func(): last_flight_time = Time.get_ticks_msec())
	SignalBus.give_item_to_chicken.connect(pick_up_item)
	SignalBus.take_item_from_chicken.connect(drop_item)
	
func register_pickable(pickable: PickableEntity):
	pickables.append(pickable)

func unregister_pickable(pickable: PickableEntity):
	pickables.erase(pickable)
	if picked_entity == pickable:
		picked_entity = null

## Picking up goes first: only if nothing gets picked the chicken interacts with what's around.
## Dropping waits until the button goes up (see on_chicken_stops_pecking)
func on_chicken_pecks(chicken: Chicken):
	if _is_pickable_available(picked_entity):
		drop_armed = true
		SignalBus.chicken_tries_interaction.emit(chicken)
		return

	drop_armed = false
	var near_pickable_index = pickables.find_custom(_pickable_is_near_character_position.bind(chicken.position))
	if near_pickable_index != -1:
		pick_up_item(chicken, pickables[near_pickable_index])
		return

	SignalBus.chicken_pecks_nothing.emit(chicken)
	if not _is_pickable_available(picked_entity): # Nobody handed anything over
		SignalBus.chicken_tries_interaction.emit(chicken)

func on_chicken_stops_pecking(chicken: Chicken):
	var should_drop := drop_armed and not drop_cancelled and chicken.action != Chicken.Action.LAYING_EGG
	drop_armed = false
	drop_cancelled = false
	if not should_drop:
		return

	var item := picked_entity
	if chicken.running:
		# Quick presses while running make the chicken fly: wait to know if that's what this press was for
		var released_time := Time.get_ticks_msec()
		await get_tree().create_timer(chicken.time_to_quick_push).timeout
		if last_flight_time >= released_time:
			return
	if picked_entity == item and _is_pickable_available(item):
		drop_item(chicken)

func cancel_drop():
	drop_cancelled = true

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
	if item == null:
		return
	picked_entity = null
	item.picked = false

	# Someone else (a door, for instance) may take the item instead of letting it fall
	SignalBus.chicken_drops_item.emit(chicken, item)
	if item.placed:
		return

	item.reparent(pickables_container)
	item.position.y += 14 # Fall from beak
	SignalBus.play_item_sound.emit(SoundManager.ItemSound.DROP)
