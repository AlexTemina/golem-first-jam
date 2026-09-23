class_name TractorManager extends Node

@export var tractor: Tractor

var chicken: Chicken

func _ready() -> void:
	SignalBus.chicken_pecks.connect(on_chicken_pecks)
	SignalBus.chicken_jumps_in_tractor.connect(on_chicken_jumps_in_tractor)
	SignalBus.chicken_is_released.connect(on_chicken_jumps_off)
	SignalBus.tractor_crashed.connect(on_tractor_crashed)
	
func _input(event: InputEvent) -> void:
	if chicken != null and event.is_action_pressed("a_button"):
		chicken_interacts()
	
func on_chicken_pecks(chicken: Chicken):
	if tractor.chicken_is_close:
		tractor.toggle_door()
	
func on_chicken_jumps_in_tractor(t_chicken: Chicken):
	chicken = t_chicken
	tractor.toggle_collisions(false)
	chicken.block(chicken.position + Vector2(0, 10))
	chicken.toggle_visibility(false)
	chicken.position = tractor.position + tractor.seat.position
	var picked_item = chicken.get_picked_item()
	if picked_item is Key:
		await wait(1)
		picked_item.destroy()
		tractor.start_engine()
		chicken.toggle_visibility()
		chicken.release()
	
func chicken_interacts():
	var picked_item = chicken.get_picked_item()
	tractor.attempt_starting_engine()
	
func on_chicken_jumps_off():
	chicken.toggle_visibility()
	tractor.toggle_collisions(true)
	chicken = null
	
func on_tractor_crashed():
	tractor.crash()

func wait(seconds: float):
	await get_tree().create_timer(seconds).timeout
