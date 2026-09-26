@tool
class_name VerticalBuilding extends StaticBody2D

@onready var right_door := $RightDoor
@onready var collisions_chicken_on_top := $CollisionsChickenOnTop
@onready var collisions_chicken_on_floor := $CollisionsChickenOnFloor

enum Type {WITH_HOLE, NORMAL}

@export var type: Type:
	set(value):
		type = value
		update_sprite()
		
@onready var sprite := $Sprite

func _ready() -> void:
	update_sprite()
	toggle_collisions(false)
		
func update_sprite():
	if sprite:
		sprite.frame = type

func open_right_door():
	right_door.open()

func toggle_collisions(on_top: bool):
	for collision_box in collisions_chicken_on_top.get_children():
		collision_box.disabled = !on_top
	for collision_box in collisions_chicken_on_floor.get_children():
		collision_box.disabled = on_top
