class_name RoadManager extends Node2D

var road: Road
var car_scene: PackedScene = load("res://golem_first_jam/entities/npc/car/car.tscn")

func _ready() -> void:
	SignalBus.chicken_crosses_road.connect(launch_car)

func init(road: Road):
	self.road = road

func launch_car():
	SignalBus.scare_chicken.emit()
	var car: Car = car_scene.instantiate()
	add_child(car)
	var road_limits = Rect2(road.position, road.get_size())
	car.init(road_limits)
