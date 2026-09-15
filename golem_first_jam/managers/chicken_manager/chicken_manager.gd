class_name ChickenManager extends Node2D

@export var chicken_starting_position: Vector2

@onready var chicken = $Chicken

func _ready() -> void:
	SignalBus.snake_scares.connect(scare_chicken)
	
	chicken.position = chicken_starting_position
	
func scare_chicken():
	chicken.scare()
