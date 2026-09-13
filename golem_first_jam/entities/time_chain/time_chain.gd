class_name TimeChain extends Node2D

const CHAIN_FRAMES = 4

@export var max_time: int = 12 # s

@onready var chain_sprite := $ChainSprite
@onready var timer := $Timer

func _ready() -> void:
	activate() # For now activates on ready
	
func _process(delta: float) -> void:
	chain_sprite.frame = CHAIN_FRAMES - (timer.time_left / max_time) * CHAIN_FRAMES

func activate():
	timer.start(max_time)

func _on_timer_timeout() -> void:
	SignalBus.game_time_over.emit()
