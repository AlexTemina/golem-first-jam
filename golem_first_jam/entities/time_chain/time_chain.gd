class_name TimeChain extends Node2D

const CHAIN_FRAMES = 4

## Time limit for the round, in seconds
@export var max_time: int = 12
## Paused modulation color
@export var paused_modulation: Color = Color(0.5, 0.5, 0.5, 0.75)

@onready var chain_sprite := $ChainSprite
@onready var timer: Timer = $Timer
@onready var animator := $Animator

func _ready() -> void:
	SignalBus.start_game_time.connect(activate)
	SignalBus.pause_game_time.connect(pause)
	SignalBus.resume_game_time.connect(resume)
	
	chain_sprite.hide()
	
func _process(delta: float) -> void:
	chain_sprite.frame = CHAIN_FRAMES - (timer.time_left / max_time) * CHAIN_FRAMES

func activate():
	animator.play("show")
	chain_sprite.show()
	timer.start(max_time)
	
func pause():
	chain_sprite.modulate = paused_modulation
	timer.paused = true
	
func resume():
	chain_sprite.modulate = Color.WHITE
	timer.paused = false

func _on_timer_timeout() -> void:
	SignalBus.game_time_over.emit()
