class_name Snake extends CharacterBody2D

@onready var snake_sound := $SnakeHiss

func _on_scare_area_body_entered(body: Node2D) -> void:
	if is_instance_of(body, Chicken):
		SignalBus.snake_scares.emit()
		if not snake_sound.playing:
			snake_sound.play()
