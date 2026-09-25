class_name LBuildingComplex extends Node2D

@onready var horizontal_building := $HorizontalBuilding
@onready var vertical_building := $VerticalBuilding
@onready var ladder := $Ladder
@onready var chimney := $Chimney

func _ready() -> void:
	SignalBus.ladder_enabled.connect(on_ladder_enabled)
	
func on_ladder_enabled():
	horizontal_building.toggle_ladder_block(false)
	horizontal_building.set_below_chicken()
