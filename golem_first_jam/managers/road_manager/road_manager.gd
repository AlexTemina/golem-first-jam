class_name RoadManager extends Node

var road: Road
var car_scene: PackedScene = load("res://golem_first_jam/entities/npc/car/car.tscn")

var car_launching_disabled := false

func _ready() -> void:
	SignalBus.chicken_crosses_road.connect(launch_car)
	SignalBus.tractor_started_moving.connect(func(): car_launching_disabled = true)

func init(t_road: Road):
	self.road = t_road

func launch_car(chicken_position: Vector2):
	if car_launching_disabled:
		return
		
	SignalBus.scare_chicken.emit()
	var car: Car = car_scene.instantiate()
	add_child(car)
	var starting_position = Vector2(road.position.x + road.get_size().x / 2, chicken_position.y + 300)
	car.init(starting_position)
