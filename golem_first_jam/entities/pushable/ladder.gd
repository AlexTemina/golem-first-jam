class_name Ladder extends PushableEntity

enum State {IDLE, FALLING, FALLEN}

@onready var sprite := $Sprite
@onready var collision_box := $CollisionShape2D
@onready var open_sound := $OpenSound
@onready var fall_sound := $FallSound

var state := State.IDLE
var angular_speed := 0.0

func _interact():
	open_sound.play()
	sprite.frame = 1
	SignalBus.ladder_enabled.emit()
	state = State.FALLING
	
func _process(delta: float) -> void:
	if State.FALLING == state:
		angular_speed -= 0.1 * delta
		rotate(angular_speed)
		if rotation_degrees < -90:
			fall_sound.play()
			state = State.FALLEN
	
