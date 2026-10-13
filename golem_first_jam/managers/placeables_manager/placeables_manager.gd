class_name PlaceablesManager extends Node

func _ready() -> void:
	SignalBus.chicken_drops_item.connect(_on_chicken_drops_item)
	SignalBus.chicken_pecks_nothing.connect(_on_chicken_pecks_nothing)
	SignalBus.chicken_tries_interaction.connect(_on_chicken_tries_interaction)

## Placing is an interaction: it happens as soon as the chicken pecks, not when the item would fall
func _on_chicken_tries_interaction(chicken: Chicken):
	var placeable = chicken.current_placeable
	if placeable == null or placeable._has_object() or chicken.get_picked_item() == null:
		return

	SignalBus.take_item_from_chicken.emit(chicken) # Drops it, and _on_chicken_drops_item places it
	SignalBus.chicken_interacted.emit(chicken)

## Instead of falling on the floor, the item rests on the placeable next to the chicken
func _on_chicken_drops_item(chicken: Chicken, item: PickableEntity):
	var placeable = chicken.current_placeable
	if placeable == null or placeable._has_object():
		return

	placeable.place_object(item)

## The chicken pecks with an empty beak next to a placeable, so it takes its object
func _on_chicken_pecks_nothing(chicken: Chicken):
	var placeable = chicken.current_placeable
	if placeable == null or not placeable._has_object():
		return

	SignalBus.give_item_to_chicken.emit(chicken, placeable.remove_object())
