class_name NightSky extends Node

@export var star_scene: PackedScene = load("res://golem_first_jam/entities/night_sky/star.tscn")

@onready var stars_container := $Stars
@onready var vision_pictogram := $VisionPictogram

func _ready() -> void:
	clear_stars()
	vision_pictogram.hide()
	
	draw_pictogram(vision_pictogram)
	
func draw_pictogram(pictogram: Polygon2D):
	var previous_point: Vector2
	for point in pictogram.polygon:
		add_star(point)
		if previous_point != null and previous_point != Vector2.ZERO:
			add_interpolated_stars(previous_point, point)
		previous_point = point
		
func add_interpolated_stars(point1: Vector2, point2: Vector2):
	var stars_number: int = point1.distance_to(point2) / 10
	print(str(point1) + ' to ' + str(point2))
	for i in range(stars_number):
		var lerp_factor = (i + 1.0) / float(stars_number)
		var star_position = lerp(point1, point2, lerp_factor)
		print(star_position)
		add_star(star_position)
		
func add_star(target_position: Vector2):
	var star = star_scene.instantiate()
	stars_container.add_child(star)
	star.init(target_position)

func clear_stars():
	for star in stars_container.get_children():
		star.queue_free()
