class_name Car extends Node2D

## Car speed in px/s
@export var speed: float = 400.0

var target_position: Vector2

@onready var sprite := $Sprite

func init(road_limits: Rect2) -> void:		
	var road_width = road_limits.size.x
	sprite.frame = randi_range(0, 2)
	position.x = road_limits.position.x + road_width * 0.5
	position.y = road_limits.position.y + road_limits.size.y
	target_position = Vector2(position.x, road_limits.position.y - 200)
	z_index = position.y
	
	# TODO Play car sound
	
func _process(delta: float) -> void:
	var new_position_delta = delta * -speed
	position.y += new_position_delta
	z_index = position.y
	
	remove_if_off_screen()

func remove_if_off_screen():
	if position.y < target_position.y:
		destroy()
			
func destroy():
	get_parent().remove_child(self)
	queue_free()
			
