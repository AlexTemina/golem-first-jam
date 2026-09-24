class_name TileMapUtils extends Node

const NO_TILE = Vector2i(-1, -1)

static func get_atlas_at_position(tilemap: TileMapLayer, position: Vector2):
	var cell = tilemap.local_to_map(tilemap.to_local(position))
	var atlas_coords = tilemap.get_cell_atlas_coords(cell)
	return atlas_coords if atlas_coords != NO_TILE else null
