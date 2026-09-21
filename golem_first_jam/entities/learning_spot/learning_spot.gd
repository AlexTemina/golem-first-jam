class_name LearningSpot extends Node2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Chicken:
		SignalBus.toggle_learning_spot.emit(true)

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Chicken:
		SignalBus.toggle_learning_spot.emit(false)
