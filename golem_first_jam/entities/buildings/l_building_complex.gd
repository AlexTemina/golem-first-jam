class_name LBuildingComplex extends Node2D

@onready var horizontal_building := $HorizontalBuilding
@onready var vertical_building := $VerticalBuilding
@onready var ladder := $Ladder
@onready var area_to_drop_egg := $AreaToDropEgg
@onready var egg_sound := $EggSound
@onready var old_lady := $OldLady

var puzzle_completed := false

func _ready() -> void:
	SignalBus.ladder_enabled.connect(on_ladder_enabled)
	SignalBus.polley_up_activated.connect(chicken_on_top)
	SignalBus.polley_up_deactivated.connect(chicken_on_floor)
	
func on_ladder_enabled():
	horizontal_building.toggle_ladder_block(false)
	horizontal_building.set_below_chicken()

func _on_area_to_drop_egg_area_entered(area: Area2D) -> void:
	if area.get_parent() is Egg:		
		var egg = area.get_parent()
		egg.destroy()
		egg_sound.play()
		if not puzzle_completed:
			puzzle_completed = true
			SignalBus.chicken_lays_egg_on_chimney.emit()			
			await wait(0.5)
			old_lady.shout()
			await wait(1.5)
			vertical_building.open_right_door()
			await wait(0.5)
			old_lady.run_away()		
		
func chicken_on_top(pulley):
	vertical_building.toggle_collisions(true)
	
func chicken_on_floor(pulley):
	vertical_building.toggle_collisions(false)

func wait(seconds: float):
	await get_tree().create_timer(seconds).timeout
