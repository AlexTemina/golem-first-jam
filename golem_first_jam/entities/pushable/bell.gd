class_name Bell extends PushableEntity

enum Id {LEARNING_BELL, LAYING_HEN_BELL, FENCE_BELL}

## Id to know which bell is interacted and to do the proper response
@export var bell_id: Id

@onready var audio_player := $AudioPlayer
@onready var sprite := $Sprite
@onready var visible_checker := $VisibleOnScreenNotifier2D

func interact():
	super()	
	sprite.play("play")
	visible_checker.is_on_screen()
	if visible_checker.is_on_screen():
		audio_player.play()
	SignalBus.bell_ringed.emit(bell_id)
