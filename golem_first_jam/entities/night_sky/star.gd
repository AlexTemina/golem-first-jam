class_name Star extends Node2D

enum State {MOVING, ON_TARGET}

## Speed in px/s
@export var speed: float = 150.0
## How random is the target position, in pixels
@export var target_point_randomness: float = 3.0

@onready var sprite := $Sprite

var state := State.MOVING
var target_position: Vector2
var sprite_color: Color
var t: float
var twinkle_speed: float

func init(target_position: Vector2):
	self.target_position = target_position
	var r = target_point_randomness
	self.target_position += Vector2(randf_range(-r, r), randf_range(-r, r))
	var starting_x = randi_range(-ScreenProps.WIDTH, ScreenProps.WIDTH * 2)
	var starting_y = randi_range(-ScreenProps.HEIGHT, ScreenProps.HEIGHT * 2)
	position = Vector2(starting_x, starting_y)
	speed = randf_range(speed * 0.8, speed * 1.5)
	sprite_color = Color.WHITE.darkened(randfn(0, 0.1))
	t = 0.0
	twinkle_speed = randf_range(10, 50)
	
func _process(delta: float) -> void:
	var calculated_speed = speed
	var target_distance = position.distance_to(target_position)
	if target_distance < 100.0:
		calculated_speed = speed * target_distance / 100.0
	var next_position = position.move_toward(target_position, delta * calculated_speed)	
	position = next_position
	t += delta
	twinkle()
	
func twinkle():
	var sprite_alpha: float
	if t < 2.0:
		sprite_alpha = t / 2.0
	else:
		sprite_alpha = 1.0 - (sin(t * twinkle_speed) / 5.0)
	sprite.modulate = sprite_color
	sprite.modulate.a = sprite_alpha
