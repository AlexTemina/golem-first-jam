class_name PickableEntity extends Node2D

## Max distance in pixels to allowing the interaction with the item
@export var max_distance_to_interact: Vector2 = Vector2(32, 16)

var picked := false
var placed := false

func _ready() -> void:
	init(self.position)

func init(t_position: Vector2):
	self.position = t_position
	z_index = int(t_position.y)
	SignalBus.register_pickable.emit(self)
	
## While placed somewhere (a polley door tray, for instance) it cannot be picked from the floor
func place():
	placed = true

## While placed somewhere (a polley door tray, for instance) it cannot be picked from the floor
func remove():
	placed = false

func destroy():
	SignalBus.unregister_pickable.emit(self)
	get_parent().remove_child(self)
	queue_free()

func is_near_character_position(character_position: Vector2) -> bool:
	var x_is_close = abs(character_position.x - global_position.x) < max_distance_to_interact.x
	var y_is_close = abs(character_position.y - global_position.y) < max_distance_to_interact.y
	return x_is_close and y_is_close
