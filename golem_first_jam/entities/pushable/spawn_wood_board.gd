class_name SpawnWoodBoard extends PushableEntity

@onready var sprite := $Sprite
@onready var sprite_broken := $SpriteBroken
@onready var collision_box := $CollisionShape2D
@onready var wood_break_sound := $WoodBreakSound

func _interact():
	wood_break_sound.play()
	sprite.hide()
	sprite_broken.show()
	collision_box.disabled = true
	SignalBus.start_game_time.emit()
