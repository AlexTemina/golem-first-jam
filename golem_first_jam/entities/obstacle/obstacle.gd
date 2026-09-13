class_name Obstacle extends RigidBody2D

@onready var collision_shape: CollisionShape2D = $CollisionShape

func _ready() -> void:
	SignalBus.enable_obstacles.connect(enable_obstacle)
	SignalBus.disable_obstacles.connect(disable_obstacle)
	
	z_index = position.y

func disable_obstacle():
	collision_shape.disabled = true

func enable_obstacle():
	collision_shape.disabled = false
