@tool
class_name Cliff extends Node2D

enum Direction {UP, DOWN, RIGHT, LEFT}

## Distance from cliff where the chicken is released
const SIZE = 32
const DROP_MARGIN = 16.0
## Offset to set the chicken's release point after dropping
const OFFSETS = {
	Direction.UP: Vector2(SIZE / 2.0, -DROP_MARGIN),
	Direction.DOWN: Vector2(SIZE / 2.0, SIZE + DROP_MARGIN),
	Direction.LEFT: Vector2(-DROP_MARGIN, SIZE / 2.0),
	Direction.RIGHT: Vector2(SIZE + DROP_MARGIN, SIZE / 2.0),
}

@export var direction: Direction:
	set(value):
		direction = value
		_apply_direction()	

@onready var sprite: AnimatedSprite2D = $Sprite

var chicken: Chicken

func _ready() -> void:
	_apply_direction()
	
func _apply_direction():
	if sprite:
		sprite.frame = direction

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Chicken:
		chicken = body
		var release_position = global_position + OFFSETS.get(direction)
		chicken.block(release_position)
		chicken.move_to(release_position)

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Chicken:		
		chicken.release()
		chicken = null
