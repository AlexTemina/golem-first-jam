class_name Bell extends PushableEntity

enum Id {CROWS_BELL, LAYING_HEN_BELL}

## Id to know which bell is interacted and to do the proper response
@export var bell_id: Id

@onready var audio_player := $AudioPlayer

func interact():
	super()
	audio_player.play()
	SignalBus.bell_ringed.emit(bell_id)
	
