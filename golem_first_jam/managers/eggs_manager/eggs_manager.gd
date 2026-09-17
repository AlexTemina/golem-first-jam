class_name EggsManager extends Node

@export var egg_scene: PackedScene = load("res://golem_first_jam/entities/egg/egg.tscn")
## Max eggs allowed. When lying more than this, the older one disappears
@export var max_eggs: int = 3

@onready var eggs_container := $Eggs

func _ready() -> void:
	SignalBus.lay_egg.connect(create_egg)
	
func create_egg(position: Vector2):
	var egg: Egg = egg_scene.instantiate()
	eggs_container.add_child(egg)
	egg.init(position)
	remove_eldest_egg()
	SignalBus.play_chicken_sound.emit(SoundManager.ChickenSound.LAY_EGG)

func remove_eldest_egg():
	if eggs_container.get_child_count() > max_eggs:
		var eldest_egg: Egg = eggs_container.get_children()[0]
		eldest_egg.break_egg()
