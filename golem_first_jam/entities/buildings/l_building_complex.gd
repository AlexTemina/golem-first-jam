class_name LBuildingComplex extends Node2D

@onready var horizontal_building := $HorizontalBuilding
@onready var vertical_building := $VerticalBuilding
@onready var ladder := $Ladder
@onready var area_to_drop_egg := $AreaToDropEgg
@onready var egg_sound := $EggSound
@onready var old_lady := $OldLady

func _ready() -> void:
	SignalBus.ladder_enabled.connect(on_ladder_enabled)
	
func on_ladder_enabled():
	horizontal_building.toggle_ladder_block(false)
	horizontal_building.set_below_chicken()

func _on_area_to_drop_egg_body_entered(body: Node2D) -> void:
	if body is Egg:
		SignalBus.chicken_lays_egg_on_chimney.emit()
		egg_sound.play()
		old_lady.run_away()

func _on_area_to_drop_egg_area_entered(area: Area2D) -> void:
	if area.get_parent() is Egg:
		SignalBus.chicken_lays_egg_on_chimney.emit()
		egg_sound.play()
		old_lady.run_away()
