class_name Snake extends CharacterBody2D

enum State {ALERT, SEARCHING_EGG, EATING_EGG}

## Movement speed in px/s
@export var speed: float = 50.0

var state := State.ALERT
var target_egg_position: Vector2

@onready var snake_sound := $SnakeHiss

func _process(delta: float) -> void:
	if state == State.SEARCHING_EGG:
		var next_position = position.move_toward(target_egg_position, delta * speed)
		position = next_position
		if target_egg_position.distance_to(next_position) < 4.0:
			state = State.EATING_EGG

func _on_scare_area_body_entered(body: Node2D) -> void:
	if is_instance_of(body, Chicken):
		SignalBus.snake_scares.emit()
		if not snake_sound.playing:
			snake_sound.play()

func go_to_egg(egg_position: Vector2):
	state = State.SEARCHING_EGG
	target_egg_position = egg_position
