class_name ObstaclesManager extends Node

func _ready():
	SignalBus.chicken_flies.connect(on_chicken_flies)
	SignalBus.chicken_lands.connect(on_chicken_lands)

func on_chicken_flies():
	SignalBus.disable_obstacles.emit()

func on_chicken_lands():
	SignalBus.enable_obstacles.emit()
