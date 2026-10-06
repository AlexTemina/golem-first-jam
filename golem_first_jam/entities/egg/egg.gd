class_name Egg extends Node2D

## Time to autodestruct. If 0, it doesn't autodestructs
@export var autodestruction_time: float = 0.0
## Time in s to get fried in a hot spot
@export var time_to_get_fried: float = 5.0

@onready var sprite := $Sprite
@onready var autodestruction_timer := $AutodestructionTimer
@onready var frying_timer := $FryingTimer
@onready var frying_sound: AudioStreamPlayer = $FryingSound
@onready var smoke: GPUParticles2D = $Smoke

var fried: bool

func init(t_position: Vector2):
	position = t_position
	if autodestruction_time > 0.0:
		autodestruction_timer.start(autodestruction_time)
	frying_timer.wait_time = time_to_get_fried
	SignalBus.egg_created.emit(self)
		
func break_egg(with_animation = true):
	if with_animation:
		sprite.play("break")
	else:
		destroy()

func _on_sprite_animation_finished() -> void:
	destroy()

func destroy():
	get_parent().remove_child(self)
	queue_free()

func _on_autodestruction_timer_timeout() -> void:
	break_egg()

func fry():
	frying_sound.play()
	frying_timer.start()

func _on_frying_timer_timeout() -> void:	
	sprite.play("fry")
	smoke.restart()
	fried = true
	SignalBus.egg_fried.emit(self)
	var tween = get_tree().create_tween()
	tween.tween_property(frying_sound, "volume_db", -12, 5)
