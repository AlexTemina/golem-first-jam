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
	if picked_entity != null:
		drop_item()
	else:
		for pickable_entity in pickables:
			if pickable_entity.is_near_character_position(chicken.global_position):
				pick_up_item(chicken, pickable_entity)
					
func pick_up_item(chicken: Chicken, item: PickableEntity):
	picked_entity = item
	item.picked = true
	item.reparent(pickables_container)
	item.position = chicken.position + chicken.get_beak_position()
	print(chicken.beak.position)
	item.reparent(chicken.beak)	
	# TODO Fix z-index

func drop_item():
	picked_entity.reparent(pickables_container)
	picked_entity.position.y += 14 # Fall from beak
	picked_entity = null
	SignalBus.play_item_sound.emit(SoundManager.ItemSound.DROP)
