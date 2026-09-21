class_name TileMapUtils extends Node

const TILE_SIZE = 32
const NO_TILE = Vector2i(-1, -1)

static func get_atlas_at_position(tilemap: TileMapLayer, position: Vector2):
	var atlas_coords = tilemap.get_cell_atlas_coords(position / TILE_SIZE)
	return atlas_coords if atlas_coords != NO_TILE else null
