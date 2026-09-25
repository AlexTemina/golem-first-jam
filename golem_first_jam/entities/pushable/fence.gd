class_name Fence extends PushableEntity

@onready var sprite_close := $SpriteClose
@onready var sprite_open := $SpriteOpen
@onready var closed_collision := $ClosedCollision
@onready var sound := $Sound

func _interact():
	closed_collision.disabled = true
	sound.play()
	sprite_open.show()
	sprite_close.hide()
