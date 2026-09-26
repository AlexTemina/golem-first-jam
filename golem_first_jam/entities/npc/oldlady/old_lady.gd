class_name OldLady extends Npc

@export var speed: float = 140

@onready var sprite := $Sprite
@onready var shout_sound := $ShoutSound

func _ready() -> void:
	hide()

func shout():
	shout_sound.play()

func run_away():
	show()
	position.x += 28.0
	sprite.z_index = 0
	velocity.x = speed
	
func _process(delta: float) -> void:
	move_and_slide()

func _on_destroy_timer_timeout() -> void:
	queue_free()
