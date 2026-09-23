class_name PushableEntity extends StaticBody2D

## Max distance in pixels to allowing the interaction with the item
@export var max_distance_to_interact: Vector2 = Vector2(32, 4)
## If the chicken can interact with the pushable
@export var pushable_by_chicken: bool = true
## If the interaction can be repeated
@export var repeatable: bool = true

var interacted: bool

func _ready() -> void:
	init(self.position)

func init(position: Vector2):
	self.position = position
	# z_index = global_position.y
	SignalBus.register_pushable.emit(self)
	
func is_near_character_position(character_position: Vector2) -> bool:
	var x_is_close = abs(character_position.x - global_position.x) < max_distance_to_interact.x
	var y_is_close = abs(character_position.y - global_position.y) < max_distance_to_interact.y
	return x_is_close and y_is_close

func interact():
	if is_interactable():
		interacted = true
		SignalBus.pushable_item_interacted.emit(self)
		_interact()
		
func _interact():
	pass # Implement in children

func is_interactable():
	return repeatable or not interacted
