class_name Crow extends Node2D

enum Action {IDLE, FLYING, INTERACTING}

## Flying speed in px/s
@export var flying_speed: float = 200.0
## If is teacher, touches the bell to show the user how to do it. Otherwise follows the bell sounds
@export var is_teacher: bool = false
## The bell that is attached to. If is teacher, it plays that bell.
@export var target_bell: Bell

@onready var sprite := $Sprite
@onready var croak_sound := $CroakSound
@onready var interaction_timer := $InteractionTimer

var starting_position: Vector2
var action := Action.IDLE
var flight_target: Vector2

func _ready() -> void:	
	SignalBus.register_crow.emit(self)
	z_index = position.y
	starting_position = self.position
	
func _process(delta: float) -> void:
	if is_flying():
		position = position.move_toward(flight_target, flying_speed * delta)
		z_index = position.y
		if position.distance_to(flight_target) < 8:
			if flight_target == starting_position:
				action = Action.IDLE
			else:
				interact()
	
func is_flying(): return action == Action.FLYING
	
func get_bell_id() -> Bell.Id:
	return target_bell.bell_id

func play_bell():
	sprite.play("peck")
	target_bell.interact()

func _on_sprite_animation_finished() -> void:
	sprite.play("default")

func fly_to_bell():
	play_croak_sound()
	fly_to(target_bell.position)
	
func fly_to(target: Vector2):
	action = Action.FLYING
	flight_target = target

func play_croak_sound():
	if not croak_sound.playing:
		croak_sound.play()
		
func interact():
	action = Action.INTERACTING
	interaction_timer.start()

func _on_interaction_timer_timeout() -> void:
	fly_to(starting_position)
