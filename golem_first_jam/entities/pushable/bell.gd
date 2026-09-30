class_name Bell extends PushableEntity

enum Id {LEARNING_BELL, CHICKEN_COUP_BELL, FENCE_BELL}

## Id to know which bell is interacted and to do the proper response
@export var bell_id: Id
## Attached item that will be triggered when the crow does its thing
@export var attached_item: PushableEntity

@onready var audio_player := $AudioPlayer
@onready var sprite := $Sprite
@onready var visible_checker := $VisibleOnScreenNotifier2D

var chicken_is_playing := false

func _interact(character: CharacterBody2D):
	sprite.play("play")
	visible_checker.is_on_screen()
	if visible_checker.is_on_screen():
		audio_player.play()
	if character is Chicken:
		chicken_is_playing = true
	SignalBus.bell_ringed.emit(self, character)
	
func interact_with_attached_item():
	if attached_item:
		attached_item.interact(null)

func get_attached_item_position():	
	return attached_item.global_position if attached_item else global_position
	
func is_learning_bell() -> bool: return bell_id == Id.LEARNING_BELL
