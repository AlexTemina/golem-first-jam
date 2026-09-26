class_name LBuildingComplex extends Node2D

@onready var horizontal_building := $HorizontalBuilding
@onready var vertical_building := $VerticalBuilding
@onready var ladder := $Ladder
@onready var area_to_drop_egg := $AreaToDropEgg
@onready var egg_sound := $EggSound
@onready var old_lady := $OldLady

func _ready() -> void:
	SignalBus.ladder_enabled.connect(on_ladder_enabled)
	SignalBus.polley_up_activated.connect(func(p): vertical_building.toggle_collisions(true))
	SignalBus.polley_up_deactivated.connect(func(p): vertical_building.toggle_collisions(false))
	
func on_ladder_enabled():
	horizontal_building.toggle_ladder_block(false)
	horizontal_building.set_below_chicken()

func _on_area_to_drop_egg_area_entered(area: Area2D) -> void:
	if area.get_parent() is Egg:
		var egg = area.get_parent()
		egg.destroy()
		SignalBus.chicken_lays_egg_on_chimney.emit()
		egg_sound.play()
		await wait(0.5)
		old_lady.shout()
		await wait(1.5)
		vertical_building.open_right_door()
		await wait(0.5)
		old_lady.run_away()
		

func wait(seconds: float):
	await get_tree().create_timer(seconds).timeout
