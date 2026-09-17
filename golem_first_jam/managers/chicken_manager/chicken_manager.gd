class_name ChickenManager extends Node2D

@export var chicken_starting_position: Vector2

var chicken: Chicken

func _ready() -> void:
	SignalBus.snake_scares.connect(scare_chicken)
	
func init(chicken: Chicken):
	self.chicken = chicken
	self.chicken.position = chicken_starting_position
	
func scare_chicken():
	chicken.scare()
