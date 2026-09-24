class_name Tractor extends Node2D

## Max speed in px/s
@export var max_speed: float = 100.0
## Acceleration in some WTF unit. Higher -> faster
@export var acceleration: float = 5.0

@onready var sprite := $Sprite2D
@onready var seat := $SeatPosition
@onready var collision_box := $StaticBody2D/Polygon2D
@onready var entrance := $DownEntrance
@onready var false_start_sound := $Sounds/FalseStartSound
@onready var engine_start_sound := $Sounds/EngineStartSound
@onready var engine_loop_sound := $Sounds/EngineLoopSound
@onready var open_door_sound := $Sounds/OpenDoor
@onready var close_door_sound := $Sounds/CloseDoor
@onready var animator := $Animator
@onready var smoke := $Smoke

var engine_started := false
var moving := false
var speed: float
var chicken_is_close := false
var door_is_open := false

func _ready() -> void:
	init()

func init():
	pass
	
func _process(delta: float) -> void:
	if moving:
		speed = lerp(speed, speed + acceleration * delta, 0.1)
		position.x += speed
	
func toggle_collisions(on := true):
	collision_box.set_deferred("disabled", !on)
	
func attempt_starting_engine():
	if not false_start_sound.playing:
		false_start_sound.play()
	
func start_engine():
	if not engine_start_sound.playing:
		engine_start_sound.play()
		animator.play("vibration")
		engine_started = true

func _on_down_entrance_body_entered(body: Node2D) -> void:
	if engine_started:
		return
	if body is Chicken:
		chicken_is_close = true
		if door_is_open:
			SignalBus.chicken_jumps_in_tractor.emit(body)
		
func _on_down_entrance_body_exited(body: Node2D) -> void:
	if body is Chicken:
		chicken_is_close = false

func _on_engine_start_sound_finished() -> void:
	engine_loop_sound.play()
	start_moving()
	
func start_moving():
	toggle_collisions()
	moving = true
	SignalBus.tractor_started_moving.emit()

func crash():
	moving = false
	animator.stop()
	engine_loop_sound.stop()
	smoke.restart()
	smoke.emitting = true
	
func toggle_door():
	door_is_open = !door_is_open
	sprite.frame = 1 if door_is_open else 0
	if door_is_open:
		open_door_sound.play()
	else:
		close_door_sound.play()
	
