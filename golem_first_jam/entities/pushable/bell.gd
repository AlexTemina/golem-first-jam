class_name Bell extends PushableEntity

enum Id {CROWS_BELL, LAYING_HEN_BELL}

@export var bell_id: Id

@onready var audio_player := $AudioPlayer

func interact():
	super()
	audio_player.play()
	SignalBus.bell_ringed.emit(bell_id)
	
