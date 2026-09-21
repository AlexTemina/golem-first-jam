class_name RiverManager extends Node

@onready var river_tilemap := %TileMapLayerRiver

func _ready() -> void:
	SignalBus.chicken_flies.connect(remove_collisions)	
	SignalBus.chicken_lands.connect(enable_collisions)
	
func remove_collisions():
	river_tilemap.collision_enabled = false
	
func enable_collisions():
	river_tilemap.collision_enabled = true
