class_name Placeable extends Node2D

## Objects accepted as valid by this placeable
@export var valid_objects: Array[PickableEntity] = []

## Max distance in pixels to allowing the interaction with the placeable
@export var max_distance_to_interact: Vector2 = Vector2(32, 16)

@onready var area_of_placeability := %Area2D

## Object currently resting on the placeable, if any
var placed_object: PickableEntity

func _ready() -> void:
	area_of_placeability.body_entered.connect(_on_body_entered)
	area_of_placeability.body_exited.connect(_on_body_exited)


func _on_body_entered(body: Node2D) -> void:
	if body is Chicken:
		SignalBus.chicken_entered_placeable.emit(self)


func _on_body_exited(body: Node2D) -> void:
	if body is Chicken:
		SignalBus.chicken_exited_placeable.emit(self)

## Leaves the object on the placeable
func place_object(object_to_place: PickableEntity) -> void:
	if object_to_place == null or _has_object():
		return

	placed_object = object_to_place
	object_to_place.place()
	object_to_place.reparent(get_object_anchor())
	object_to_place.position = Vector2.ZERO
	object_to_place.z_index = 1 # Relative to the placeable, to draw over it

	_on_object_placed(object_to_place, _is_valid_object(object_to_place))

## Takes the object out of the placeable and returns it
func remove_object() -> PickableEntity:
	if not _has_object():
		return null

	var recovered_object := placed_object
	placed_object = null
	recovered_object.remove()
	_on_object_removed(recovered_object)

	return recovered_object

## Checks if the character is close enough to the placeable to interact with it
func is_near_character_position(character_position: Vector2) -> bool:
	var x_is_close = abs(character_position.x - global_position.x) < max_distance_to_interact.x
	var y_is_close = abs(character_position.y - global_position.y) < max_distance_to_interact.y
	return x_is_close and y_is_close

func _has_object() -> bool:
	return is_instance_valid(placed_object)

func _is_valid_object(object_to_validate: PickableEntity) -> bool:
	if object_to_validate == null:
		return false

	return valid_objects.has(object_to_validate)

## Where the object rests. Implement in children to use another node
func get_object_anchor() -> Node2D:
	return self

func _on_object_placed(object_placed: PickableEntity, is_valid: bool):
	pass # Implement in children

func _on_object_removed(object_removed: PickableEntity):
	pass # Implement in children
