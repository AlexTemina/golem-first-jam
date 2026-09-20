class_name Bell extends PushableEntity

enum Id {LEARNING_BELL, LAYING_HEN_BELL, FENCE_BELL}

## Id to know which bell is interacted and to do the proper response
@export var bell_id: Id

@onready var audio_player := $AudioPlayer
@onready var sprite := $Sprite

func interact():
	super()
	audio_player.play()
	sprite.play("play")
	SignalBus.bell_ringed.emit(bell_id)
	
