@tool
class_name PolleyDoor extends Placeable

@onready var closed_sprite := %ClosedSprite
@onready var opened_sprite := %OpenedSprite
@onready var collision_box := %CollisionShape2D
@onready var object_anchor := %ObjectAnchor
@onready var size_label_node := %SizeLabel

## Letter shown over the door, just to hint which rock it takes
@export var size_label: String = "":
	set(new_size_label):
		size_label = new_size_label
		_refresh_size_label()

## Whether the door is open or closed
var opened: bool

func _ready() -> void:
	super._ready()
	refresh()
	_refresh_size_label()

## Also runs while editing, as the script is a @tool
func _refresh_size_label() -> void:
	if not is_node_ready():
		return

	size_label_node.text = size_label

## The tray, where the object rests
func get_object_anchor() -> Node2D:
	return object_anchor

func _on_object_placed(object_placed: PickableEntity):
	if _is_valid_object(object_placed):
		open()

func _on_object_removed(object_removed: PickableEntity):
	if opened:
		close(object_removed)

## Opens the door and emits a signal to notify that it has been opened
func open() -> void:
	opened = true
	refresh()
	SignalBus.polley_door_opened.emit(placed_object)

## Closes the door and emits a signal to notify that it has been closed
func close(object: PickableEntity) -> void:
	opened = false
	refresh()
	SignalBus.polley_door_closed.emit(object)

func refresh() -> void:
	closed_sprite.visible = not opened
	opened_sprite.visible = opened
	collision_box.set_deferred("disabled", opened)
