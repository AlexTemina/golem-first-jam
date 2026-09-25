class_name Chimney extends PushableEntity

@onready var sprite := $Sprite
@onready var chicken_target := $ChickenTarget
@onready var collision_box := $CollisionShape2D
@onready var egg_sound := $EggSound

func _interact():
	collision_box.disabled = true
	SignalBus.chicken_uses_chimney.emit(chicken_target.global_position)	

func create_nest():
	egg_sound.play()
	sprite.frame = 1
	collision_box.disabled = false
