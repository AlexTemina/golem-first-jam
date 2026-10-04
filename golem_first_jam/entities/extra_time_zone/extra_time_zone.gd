@tool
class_name ExtraTimeZone extends Node2D

## Area to detect the extra time addition
@export var custom_shape: Shape2D:
	set(value):
		custom_shape = value
		_apply_custom_shape()
		
## Extra seconds you receive when entering this area
@export var extra_time: float = 5.0

@onready var area_2d: Area2D = $Area2D
@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D

## When extra time has been consumed. Resets every round
var consumed := false

func _ready():
	_apply_custom_shape()

func _apply_custom_shape() -> void:
	if collision_shape_2d:
		collision_shape_2d.shape = custom_shape
	
func reset():
	consumed = false
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if not consumed and body is Chicken:
		add_extra_time()

func add_extra_time():
	consumed = true
	print('Extra time added: ' + str(extra_time))
	SignalBus.add_extra_time.emit(extra_time)
