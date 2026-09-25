class_name Ladder extends PushableEntity

@onready var sprite := $Sprite
@onready var collision_box := $CollisionShape2D
@onready var sound := $Sound

func _interact():
	sound.play()
	sprite.frame = 1
	collision_box.disabled = true
	SignalBus.ladder_enabled.emit()
