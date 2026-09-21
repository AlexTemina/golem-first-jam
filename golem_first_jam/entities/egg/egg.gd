class_name Egg extends Node2D

## Time to autodestruct. If 0, it doesn't autodestructs
@export var autodestruction_time: float = 0.0

@onready var sprite := $Sprite
@onready var autodestruction_timer := $AutodestructionTimer

func init(position: Vector2):
	self.position = position
	z_index = position.y
	if autodestruction_time > 0.0:
		autodestruction_timer.start(autodestruction_time)
		
func break_egg():
	sprite.play("break")

func _on_sprite_animation_finished() -> void:
	destroy()

func destroy():
	get_parent().remove_child(self)
	queue_free()

func _on_autodestruction_timer_timeout() -> void:
	break_egg()
