class_name GodModeManager extends Node

## Debug only: F12 toggles god mode. While on, the chicken ignores collisions and areas,
## click anywhere to teleport it there, or fly it around with the arrows.

@export var chicken: Chicken
## In px/s, while flying around with the arrows
@export var fly_speed: float = 300.0

func _ready() -> void:
	set_process(false)

func _input(event: InputEvent) -> void:
	if not OS.is_debug_build() or chicken == null:
		return
	if event is InputEventKey and event.pressed and not event.echo and event.keycode == KEY_F12:
		toggle_god_mode(not chicken.god_mode)
		get_viewport().set_input_as_handled()
	elif chicken.god_mode and event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		chicken.global_position = chicken.get_global_mouse_position()
		get_viewport().set_input_as_handled()

func _process(delta: float) -> void:
	var direction := Input.get_vector("left", "right", "up", "down")
	chicken.global_position += direction * fly_speed * delta

func toggle_god_mode(on: bool):
	chicken.toggle_god_mode(on)
	set_process(on)
	print("God mode ", "ON" if on else "OFF")
