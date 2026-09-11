class_name EggsManager extends Node2D

@export var egg_scene: PackedScene = load("res://golem_first_jam/entities/egg/egg.tscn")

func _ready() -> void:
	SignalBus.lay_egg.connect(create_egg)
	
func create_egg(position: Vector2):
	var egg = egg_scene.instantiate()
	add_child(egg)
	egg.position = position
