class_name Clearing extends Node2D

## Only used for NPCs
@export var npc_only: bool = false

func _on_learning_area_body_entered(body: Node2D) -> void:
	if npc_only:
		return
	if body is Chicken:
		SignalBus.toggle_learning_spot.emit(true)

func _on_learning_area_body_exited(body: Node2D) -> void:
	if npc_only:
		return
	if body is Chicken:
		SignalBus.toggle_learning_spot.emit(false)
