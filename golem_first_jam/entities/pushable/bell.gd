class_name Bell extends PushableEntity

@onready var audio_player := $AudioPlayer

func interact():
	super()
	audio_player.play()
	
