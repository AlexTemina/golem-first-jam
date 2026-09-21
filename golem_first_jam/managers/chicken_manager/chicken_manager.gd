class_name ChickenManager extends Node

@export var chicken_starting_position: Vector2

var chicken: Chicken

func _ready() -> void:
	SignalBus.scare_chicken.connect(scare_chicken)
	SignalBus.toggle_learning_spot.connect(toggle_learning)
	
func init(chicken: Chicken):
	self.chicken = chicken
	self.chicken.position = chicken_starting_position
	
func scare_chicken():
	chicken.scare()

func toggle_learning(on: bool):
	chicken.learning = on
