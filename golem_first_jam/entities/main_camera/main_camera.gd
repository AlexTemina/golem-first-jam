extends Node

## Make camera follow this node
@export var camera_target: Node2D
## Static canvas layer, always on camera
@export var canvas_layer: CanvasLayer

@onready var phantom_camera: PhantomCamera2D = %PhantomCamera2D

func _ready() -> void:
	SignalBus.follow_object.connect(follow_object)
	SignalBus.add_node_to_canvas.connect(add_node_to_canvas)
	if camera_target == null:
		print("WARNING: missing camera target")
	else:
		follow_object(camera_target)

func follow_object(node: Node2D):
	phantom_camera.follow_target = node

func add_node_to_canvas(node: Node2D):
	if canvas_layer:
		canvas_layer.add_child(node)
		
