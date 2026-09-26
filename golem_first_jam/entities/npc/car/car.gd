class_name Car extends Node2D

## Car speed in px/s
@export var speed: float = 400.0

var target_position: Vector2
var sound_effects = [load("res://golem_first_jam/entities/npc/car/assets/car-skid.wav"), 
					load("res://golem_first_jam/entities/npc/car/assets/horn.wav")]

@onready var sprite := $Sprite
@onready var car_passing_sound := $CarPassing
@onready var car_effect := $CarEffect
@onready var sound_effect_timer := $SoundTimer
@onready var brake_timer := $BrakeTimer

var braking := false
var stopped := false

func init(starting_position: Vector2, brake := false) -> void:		
	sprite.frame = randi_range(0, 2)
	position = starting_position
	target_position = starting_position - Vector2(0, 3000)
	car_passing_sound.play()	
	sound_effect_timer.start(randf_range(0.2, 0.5))
	if brake:
		brake_timer.start()
	
func _process(delta: float) -> void:
	if stopped:
		return
		
	if braking:
		speed -= delta * 500.0
		if speed < 0:
			speed = 0
			stopped = true
		
	var new_position_delta = delta * -speed
	position.y += new_position_delta
	
	remove_if_off_screen()

func remove_if_off_screen():
	if not stopped and not car_passing_sound.playing and position.y < target_position.y:
		destroy()
			
func destroy():
	get_parent().remove_child(self)
	queue_free()
			
func _on_sound_timer_timeout() -> void:
	if randf() > 0.3:
		play_effect_sound()
	
func play_effect_sound():
	car_effect.stream = sound_effects.pick_random()
	car_effect.pitch_scale = randf_range(0.8, 1.2)
	car_effect.play()

func _on_car_passing_finished() -> void:
	if not stopped:
		destroy()

func _on_brake_timer_timeout() -> void:
	braking = true
