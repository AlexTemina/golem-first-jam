@tool
class_name PolleyDoor extends Placeable

@onready var closed_sprite := %ClosedSprite
@onready var opened_sprite := %OpenedSprite
@onready var collision_box := %CollisionShape2D
@onready var object_anchor := %ObjectAnchor
@onready var pulley_sound := %PulleySound

enum Size {S, M, L}

## Sprites for each size, closed (door down) and opened (door up). The marks on the post hint which rock it takes
const SPRITES := {
	Size.S: [preload("res://golem_first_jam/entities/polley_door/assets/Poley_S_Down.png"), preload("res://golem_first_jam/entities/polley_door/assets/Poley_S_Up.png")],
	Size.M: [preload("res://golem_first_jam/entities/polley_door/assets/Poley_M_Down.png"), preload("res://golem_first_jam/entities/polley_door/assets/Poley_M_Up.png")],
	Size.L: [preload("res://golem_first_jam/entities/polley_door/assets/Poley_L_Down.png"), preload("res://golem_first_jam/entities/polley_door/assets/Poley_L_Up.png")],
}

## Which rock it takes, shown by the sprite
@export var size: Size = Size.S:
	set(new_size):
		size = new_size
		_refresh_sprites()
## Where the object rests while the door is closed (tray up) and opened (tray down, it weighs)
@export var closed_anchor_position: Vector2
@export var opened_anchor_position: Vector2

## Whether the door is open or closed
var opened: bool

func _ready() -> void:
	super._ready()
	refresh()
	_refresh_sprites()

## Also runs while editing, as the script is a @tool
func _refresh_sprites() -> void:
	if not is_node_ready():
		return

	closed_sprite.texture = SPRITES[size][0]
	opened_sprite.texture = SPRITES[size][1]

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
	play_sound()
	refresh()
	SignalBus.polley_door_opened.emit(placed_object)

## Closes the door and emits a signal to notify that it has been closed
func close(object: PickableEntity) -> void:
	opened = false
	play_sound()
	refresh()
	SignalBus.polley_door_closed.emit(object)

func refresh() -> void:
	closed_sprite.visible = not opened
	opened_sprite.visible = opened
	collision_box.set_deferred("disabled", opened)
	object_anchor.position = opened_anchor_position if opened else closed_anchor_position

func play_sound():
	pulley_sound.pitch_scale = randf_range(0.8, 1.2)
	pulley_sound.play()
	
