class_name SpawnWoodBoard extends PushableEntity

@onready var sprite := $Sprite
@onready var sprite_broken := $SpriteBroken
@onready var collision_box := $CollisionShape2D

func _interact():
	# TODO Play some sound
	sprite.hide()
	sprite_broken.show()
	collision_box.disabled = true
