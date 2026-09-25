class_name Ladder extends PushableEntity

@onready var sprite := $Sprite
@onready var collision_box := $CollisionShape2D

func _interact():
	sprite.frame = 1
	collision_box.disabled = true
	SignalBus.ladder_enabled.emit()
