class_name OldLady extends Npc

@export var speed: float = 140

@onready var sprite := $Sprite

func run_away():
	position.x += 20.0
	sprite.z_index = 0
	velocity.x = speed
	
func _process(delta: float) -> void:
	move_and_slide()

func _on_destroy_timer_timeout() -> void:
	queue_free()
