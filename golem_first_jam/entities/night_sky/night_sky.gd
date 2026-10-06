class_name NightSky extends Node2D

@export var star_scene: PackedScene = load("res://golem_first_jam/entities/night_sky/star.tscn")

@onready var stars_container := $Stars
@onready var vision_pictogram_q := $Pictograms/VisionPictogramQ
@onready var vision_pictogram_e := $Pictograms/VisionPictogramE

func _ready() -> void:
	pass
	#draw_text_stars("DRAW SOMETHIN STUPID CHICKEN")
	
func init():
	pass
	
func draw_pictogram(pictogram: Polygon2D):
	vision_pictogram_q.hide()
	vision_pictogram_e.hide()
	var previous_point: Vector2
	for point in pictogram.polygon:
		add_star(point)
		if previous_point != null and previous_point != Vector2.ZERO:
			add_interpolated_stars(previous_point, point)
		previous_point = point
		
func draw_text_stars(pictogram_text: String):
	var text_lines = split_into_words(pictogram_text)
	var letter_scale = 4
	var letter_position = Vector2(5, 5)
	for text_line in text_lines:
		# Set letter x depending on the lenght of the word. The longer, the more to the left, to simulate centered font
		letter_position.x = 100 - (text_line.length() * letter_scale * 5) / 2
		for letter in text_line:			
			var letter_lines = Pictograms.get_letter_lines(letter)
			for line in letter_lines:
				for i in range(line.size() - 1):
					var p1 = letter_position + Vector2(line[i]) * letter_scale
					var p2 = letter_position + Vector2(line[i + 1]) * letter_scale
					add_interpolated_stars(p1, p2)
			letter_position.x += letter_scale * 10		
		letter_position.y += letter_scale * 12 if text_lines.size() > 2 else letter_scale * 12 * 2
		
func split_into_words(pictogram_text: String) -> PackedStringArray:
	var text_lines = pictogram_text.split(" ")
	var i = 0
	while i < text_lines.size() - 1:
		var current_line = text_lines[i]
		var next_line = text_lines[i + 1]
		if current_line.length() <= 3 and next_line.length() <= 3:
			text_lines[i] = current_line + " " + next_line
			text_lines.remove_at(i + 1)
		else:
			i += 1
	return text_lines
		
func add_interpolated_stars(point1: Vector2, point2: Vector2):
	var stars_number := int(point1.distance_to(point2) / 5)
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
