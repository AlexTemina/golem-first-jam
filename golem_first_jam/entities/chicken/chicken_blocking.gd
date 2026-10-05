class_name ChickenBlocking extends RefCounted

var chicken: Chicken
var blocked := false # For some puzzles, keep the chicken blocked
var release_position: Vector2 # When release, where teleports
var release_buttons: Array # Buttons to release itself. If no buttons, is fully blocked, has to be released by code

func _init(_chicken: Chicken) -> void:
	chicken = _chicken
	
func is_blocked():
	return blocked

func manage_blockness():
	for inputs in release_buttons:		
		if Input.is_action_just_pressed(inputs):
			release()

func block(t_release_position: Vector2, t_release_buttons: Array = [], new_action := Chicken.Action.NONE):
	chicken.set_action(new_action)
	blocked = true	
	release_buttons = t_release_buttons
	release_position = t_release_position
	chicken.play_idle_legs()
	chicken.abort_egg()
	
func release():
	if not blocked:
		return
	blocked = false
	chicken.set_global_position(release_position)
	release_position = Vector2.ZERO	
	chicken.play_idle_legs()
	chicken.reset_state()
	SignalBus.chicken_is_released.emit()
