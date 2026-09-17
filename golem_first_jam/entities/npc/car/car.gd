class_name Car extends Node2D

enum Direction {UP, DOWN}

## Car speed in px/s
@export var speed: float = 400.0
## Direction of the car
@export var direction: Direction

var target_position: Vector2

@onready var sprite := $Sprite

func init(road_limits: Rect2) -> void:	
	direction = Direction.get(Direction.keys().pick_random())
	var road_width = road_limits.size.x
	if is_going_up():
		sprite.frame = 0
		position.x = road_limits.position.x + road_width * 0.75 # Right lane
		position.y = road_limits.position.y + road_limits.size.y
		target_position = Vector2(position.x, road_limits.position.y - 200)
	else:
		sprite.frame = 1
		position.x = road_limits.position.x  + road_width * 0.25 # Left lane
		position.y = road_limits.position.y
		target_position = Vector2(position.x, road_limits.position.y + road_limits.size.y + 200)
	print('Car going %s from %s' % ['up' if is_going_up() else 'down', position])
	z_index = position.y
	
	# TODO Play car sound
	
func _process(delta: float) -> void:
	var new_position_delta = delta * speed
	if is_going_up():
		new_position_delta = -new_position_delta
	position.y += new_position_delta
	z_index = position.y
	
	remove_if_off_screen()
	
func is_going_up() -> bool:
	return direction == Direction.UP

func remove_if_off_screen():
	if is_going_up() and position.y < target_position.y:
		destroy()
	elif not is_going_up() and position.y > target_position.y:
		destroy()
			
func destroy():
	get_parent().remove_child(self)
	queue_free()
			
