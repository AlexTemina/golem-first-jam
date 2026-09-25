class_name PolleyUp extends Placeable

@onready var down_sprite := %DownSprite
@onready var up_sprite := %UpSprite
@onready var object_anchor := %ObjectAnchor
@onready var loaded_anchor := %LoadedAnchor
@onready var up_anchor := %UpAnchor

## Where the chicken ends up instead of on the raised platform, usually a spot in a building
@export var up_position: Node2D

## Whether the door is activate or closed
var activated: bool

## Where the chicken boards the polley, to bring it back down
var down_position: Vector2

## Where the tray rests while the polley is down, to bring it back up
var idle_anchor_position: Vector2

func _ready() -> void:
	super._ready()
	down_position = area_of_placeability.global_position
	idle_anchor_position = object_anchor.global_position
	refresh()

## Where the chicken rides to: its own raised platform, unless you point it somewhere else
func get_up_position() -> Vector2:
	return up_position.global_position if up_position else up_anchor.global_position

## Wherever the polley stands right now, which is where the chicken rides it
func get_chicken_position() -> Vector2:
	return area_of_placeability.global_position

## The tray, where the object rests
func get_object_anchor() -> Node2D:
	return object_anchor

func _on_object_placed(object_placed: PickableEntity):
	if _is_valid_object(object_placed):
		activate()

func _on_object_removed(_object_removed: PickableEntity):
	if activated:
		deactivate()

## Goes up and emits a signal to notify that it has been activated
func activate() -> void:
	activated = true
	_move_polley(get_up_position(), loaded_anchor.global_position)
	refresh()
	SignalBus.polley_up_activated.emit(self)

## Goes back down and emits a signal to notify that it has been deactivated
func deactivate() -> void:
	activated = false
	_move_polley(down_position, idle_anchor_position)
	refresh()
	SignalBus.polley_up_deactivated.emit(self)

## Both ends of the rope travel together: the tray goes down as the chicken goes up
func _move_polley(chicken_side: Vector2, tray_side: Vector2) -> void:
	area_of_placeability.global_position = chicken_side
	object_anchor.global_position = tray_side

func refresh() -> void:
	down_sprite.visible = not activated
	up_sprite.visible = activated
