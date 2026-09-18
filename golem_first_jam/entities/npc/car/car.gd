class_name Car extends Node2D

## Car speed in px/s
@export var speed: float = 400.0

var target_position: Vector2

@onready var sprite := $Sprite

func init(starting_position: Vector2) -> void:		
	sprite.frame = randi_range(0, 2)
	position = starting_position
	target_position = starting_position - Vector2(0, 800)
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
			
