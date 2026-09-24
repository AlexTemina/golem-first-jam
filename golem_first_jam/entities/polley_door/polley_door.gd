class_name PolleyDoor extends Placeable

@onready var closed_sprite := %ClosedSprite
@onready var opened_sprite := %OpenedSprite
@onready var collision_box := %CollisionShape2D
@onready var object_anchor := %ObjectAnchor

## Whether the door is open or closed
var opened: bool

func _ready() -> void:
	refresh()

## The tray, where the object rests
func get_object_anchor() -> Node2D:
	return object_anchor

func _on_object_placed(object_placed: PickableEntity, is_valid: bool):
	if is_valid:
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
