class_name SnakeManager extends Node

## Max distance to be attracted to an egg
@export var max_distance_to_egg: int = 100

var snake: Snake

func _ready() -> void:
	SignalBus.lay_egg.connect(on_chicken_lays_egg)
	
func init(snake: Snake):
	self.snake = snake
	
func on_chicken_lays_egg(egg_position: Vector2):
	var distance_to_egg = egg_position.distance_to(snake.position)
	if distance_to_egg <= max_distance_to_egg:
		snake.go_to_egg(egg_position)
