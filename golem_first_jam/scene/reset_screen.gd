class_name ResetScreen extends Node2D

@onready var dog_bark := $DogBark

func _ready() -> void:
	hide()
	
func show_screen():
	show()
	dog_bark.play()
