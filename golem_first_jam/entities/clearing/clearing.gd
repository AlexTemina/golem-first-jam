class_name Clearing extends Node2D

## Only used for NPCs
@export var npc_only: bool = false
## Text to be showed as glowing stars
@export var help_text: String = 'TEST'

func _on_learning_area_body_entered(body: Node2D) -> void:
	if npc_only:
		return
	if body is Chicken:
		SignalBus.toggle_learning_spot.emit(true, help_text)

func _on_learning_area_body_exited(body: Node2D) -> void:
	if npc_only:
		return
	if body is Chicken:
		SignalBus.toggle_learning_spot.emit(false, '')
