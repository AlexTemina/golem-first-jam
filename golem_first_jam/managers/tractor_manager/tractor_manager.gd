class_name TractorManager extends Node

@export var tractor: Tractor

var chicken: Chicken

func _ready() -> void:
	SignalBus.chicken_jumps_in_tractor.connect(on_chicken_jumps_in_tractor)
	SignalBus.chicken_is_released.connect(on_chicken_jumps_off)
	
func _input(event: InputEvent) -> void:
	if chicken != null and event.is_action_pressed("a_button"):
		chicken_interacts()
	
func on_chicken_jumps_in_tractor(chicken: Chicken):
	self.chicken = chicken
	tractor.toggle_collisions(false)
	chicken.block(chicken.position + Vector2(0, 10))
	chicken.face_right()
	chicken.position = tractor.position + tractor.seat.position
	
func chicken_interacts():
	var picked_item = chicken.get_picked_item()
	if picked_item is Key:
		picked_item.destroy()
		tractor.start_engine()
		chicken.release()
	else:
		tractor.attempt_starting_engine()
	
func on_chicken_jumps_off():
	tractor.toggle_collisions(true)
	chicken = null
