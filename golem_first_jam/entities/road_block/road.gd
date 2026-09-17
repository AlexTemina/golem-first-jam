class_name Road extends Node2D

## If true, the road is an obstacle that scares the chicken
@export var obstacle_enabled: bool = true

@onready var sprite := $Sprite
@onready var scare_collision_shape := $ScareArea/CollisionShape2D

func get_size() -> Vector2:
	return scare_collision_shape.shape.get_rect().size

func _on_scare_area_body_entered(body: Node2D) -> void:
	if obstacle_enabled and is_instance_of(body, Chicken):
		SignalBus.chicken_crosses_road.emit()
