class_name Ladder extends PushableEntity

enum State {IDLE, FALLING, FALLEN}

@onready var sprite := $Sprite
@onready var collision_box := $CollisionShape2D
@onready var open_sound := $OpenSound
@onready var fall_sound := $FallSound

## Apparent length of the fallen ladder relative to the standing one (perspective)
@export var fallen_length_ratio: float = 1.15

var state := State.IDLE
var angular_speed := 0.0
var fall_angle := 0.0

func _interact(_character: CharacterBody2D):
	open_sound.play()
	sprite.frame = 0
	SignalBus.ladder_enabled.emit()
	state = State.FALLING
	
func _process(delta: float) -> void:
	if State.FALLING == state:
		angular_speed += 0.1 * delta
		fall_angle = minf(fall_angle + angular_speed, PI / 2.0)
		sprite.scale.y = cos(fall_angle) + sin(fall_angle) * fallen_length_ratio
		if fall_angle >= PI / 2.0:
			collision_box.set_deferred("disabled", true)
			fall_sound.play()
			state = State.FALLEN
			
			# Fix the offset to make it appear under the chicken
			sprite.offset.y = 28
			sprite.position.y -= 60
