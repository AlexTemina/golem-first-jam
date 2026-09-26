class_name ResetScreen extends Node2D

@onready var dog_bark := $DogBark
@onready var cluck := $Cluck

func _ready() -> void:
	hide()
	
func show_screen():
	show()
	dog_bark.play()
	cluck.play()
	
