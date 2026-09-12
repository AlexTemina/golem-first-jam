class_name SoundManager extends Node2D

enum ChickenSound {WALK, PECK, LAY_EGG, FLY, CACKLE}

var CHICKEN_SOUNDS = {
	ChickenSound.WALK: [],
	ChickenSound.PECK: [],
	ChickenSound.LAY_EGG: [load("res://golem_first_jam/managers/sound_manager/assets/pop1.wav"), 
	load("res://golem_first_jam/managers/sound_manager/assets/pop2.wav")],
	ChickenSound.FLY: [],
	ChickenSound.CACKLE: [],
}

@export var pitch_randomness: float = 0.2 # Default pitch is 1, the randomness set the range below and above this default value

@onready var chicken_player: AudioStreamPlayer = $ChickenPlayer

func _ready() -> void:
	SignalBus.play_chicken_sound.connect(play_chicken_sound)
	
func play_chicken_sound(sound_id: ChickenSound):
	var sounds: Array = CHICKEN_SOUNDS.get(sound_id)
	play_sound(chicken_player, sounds.pick_random())
	
func play_sound(player: AudioStreamPlayer, stream: AudioStream):
	player.stream = stream
	player.pitch_scale = randf_range(1 - pitch_randomness, 1 + pitch_randomness)
	player.play()
