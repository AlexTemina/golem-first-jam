class_name TimeChain extends Node2D

const CHAIN_FRAMES = 4

## Time limit for the round, in seconds
@export var max_time: int = 12
## Paused modulation color
@export var paused_modulation: Color = Color(0.5, 0.5, 0.5, 0.75)

@onready var chain_sprite := $ChainSprite
@onready var normal_timer: Timer = $ChainTimer
@onready var extra_timer: Timer = $ExtraTimer
@onready var animator := $Animator
@onready var chain_sound := $ChainSound

var time_started := false
var previous_frame = 0
var extra_time := 0.0

func _ready() -> void:
	SignalBus.start_game_time.connect(activate)
	SignalBus.pause_game_time.connect(pause)
	SignalBus.resume_game_time.connect(resume)
	SignalBus.reset_game.connect(reset)
	SignalBus.add_extra_time.connect(add_extra_time)
	
	reset()
	
func _process(delta: float) -> void:
	previous_frame = chain_sprite.frame
	chain_sprite.frame = CHAIN_FRAMES - (normal_timer.time_left / max_time) * CHAIN_FRAMES
	if chain_sprite.visible and previous_frame != chain_sprite.frame:
		play_chain_sound()
		
func reset():
	time_started = false
	extra_time = 0.0
	chain_sprite.hide()

func activate():
	if not time_started:
		time_started = true
		animator.play("show")
		chain_sprite.show()
		normal_timer.start(max_time)
	
func pause():
	chain_sprite.modulate = paused_modulation
	normal_timer.paused = true
	
func resume():
	chain_sprite.modulate = Color.WHITE
	normal_timer.paused = false
	
func add_extra_time(more_time: float):
	extra_time += more_time

# Normal timer
func _on_timer_timeout() -> void:
	play_chain_sound()
	time_started = false
	SignalBus.normal_time_over.emit()
	extra_timer.start(extra_time)
	
func play_chain_sound():
	chain_sound.pitch_scale = randf_range(0.8, 1.2)
	chain_sound.play()

func _on_extra_timer_timeout() -> void:
	SignalBus.game_time_over.emit()
