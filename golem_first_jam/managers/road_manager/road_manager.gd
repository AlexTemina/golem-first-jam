class_name RoadManager extends Node

## Time to wait since the tractor started engine to the last car launch
@export var last_car_wait_time: float = 3.0

@onready var last_car_timer := $LastCarTimer

var road: Road
var car_scene: PackedScene = load("res://golem_first_jam/entities/npc/car/car.tscn")
var car_launching_disabled := false

func _ready() -> void:
	SignalBus.chicken_crosses_road.connect(on_chicken_crosses_road)
	SignalBus.tractor_started_moving.connect(launch_last_car)

func init(t_road: Road):
	self.road = t_road

func on_chicken_crosses_road(chicken_position: Vector2):
	if not car_launching_disabled:
		launch_car(chicken_position.y + 300)
		
func launch_last_car():
	car_launching_disabled = true
	last_car_timer.start(last_car_wait_time)

func _on_last_car_timer_timeout() -> void:
	launch_car(road.position.y - 1000) # TODO FIx the road offset to make the cars appear 

func launch_car(y_position: float):
	SignalBus.scare_chicken.emit()
	var car: Car = car_scene.instantiate()
	add_child(car)
	var starting_position = Vector2(road.position.x, y_position)
	car.init(starting_position)
