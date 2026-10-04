class_name ExtraTimeManager extends Node

## Node which contains the ExtraTimeZone nodes
@export var zones_container: Node2D

@onready var extra_timer: Timer = $Timer

var extra_time := 0.0

func _ready() -> void:
	SignalBus.add_extra_time.connect(add_extra_time)
	SignalBus.normal_time_over.connect(on_normal_time_over)

func init():
	reset()
	
func reset():
	extra_time = 0.0
	for zone in find_extra_time_zones():
		zone.reset()

func find_extra_time_zones() -> Array:
	return zones_container.find_children("*", "ExtraTimeZone")

func add_extra_time(more_time: float):
	extra_time += more_time
	
func on_normal_time_over():
	if extra_time > 0:
		extra_timer.start(extra_time)
	else:
		time_over()		
		
func _on_timer_timeout() -> void:
	time_over()

func time_over():
	SignalBus.game_time_over.emit()
