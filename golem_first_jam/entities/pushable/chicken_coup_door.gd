class_name ChickenCoupDoor extends PushableEntity

@onready var collision_box := $CollisionShape2D
@onready var open_sprite := $OpenSprite
@onready var closed_sprite := $ClosedSprite
@onready var door_sound := $DoorSound

func _interact():
	door_sound.play()
	open_sprite.show()
	closed_sprite.hide()
	collision_box.disabled = true
	SignalBus.chicken_coup_door_opened.emit()
