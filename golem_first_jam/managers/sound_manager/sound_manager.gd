class_name SoundManager extends Node

enum ChickenSound {WALK, PECK, LAY_EGG, FLY, CACKLE}
enum ItemSound {DROP}

const SOUNDS_BUS = 1

var CHICKEN_SOUNDS = {
	ChickenSound.WALK: [],
	ChickenSound.PECK: [],
	ChickenSound.LAY_EGG: [load("res://golem_first_jam/managers/sound_manager/assets/pop1.wav"), 
		load("res://golem_first_jam/managers/sound_manager/assets/pop2.wav")],
	ChickenSound.FLY: [load("res://golem_first_jam/managers/sound_manager/assets/fly1.wav"), 
		load("res://golem_first_jam/managers/sound_manager/assets/fly2.wav")],
	ChickenSound.CACKLE: [],
}

var ITEM_SOUNDS = {
	ItemSound.DROP: [load("res://golem_first_jam/managers/sound_manager/assets/drop_item.wav")]
}

## Default pitch is 1 (in exponential scale), the randomness sets the range below and above this default value.
## For instance: 0.5 goes from 0.5 (one octave down) to 1.5 (half an octave up).
@export var pitch_randomness: float = 0.2

@onready var chicken_player: AudioStreamPlayer = $ChickenPlayer
@onready var items_player: AudioStreamPlayer = $ItemsPlayer

func _ready() -> void:
	SignalBus.set_sounds_volume.connect(change_global_volume)
	SignalBus.play_chicken_sound.connect(play_chicken_sound)
	SignalBus.play_item_sound.connect(play_item_sound)
	SignalBus.chicken_flies.connect(play_fly_sound)
	
func change_global_volume(value: float):
	AudioServer.set_bus_volume_linear(SOUNDS_BUS, value / 100.0)
	
func play_fly_sound(): play_chicken_sound(ChickenSound.FLY)
	
func play_chicken_sound(sound_id: ChickenSound):
	var sounds: Array = CHICKEN_SOUNDS.get(sound_id)
	play_sound(chicken_player, sounds.pick_random())
	
func play_item_sound(sound_id: ItemSound):
	var sounds: Array = ITEM_SOUNDS.get(sound_id)
	play_sound(items_player, sounds.pick_random())
	
func play_sound(player: AudioStreamPlayer, stream: AudioStream):
	player.stream = stream
	player.pitch_scale = randf_range(1 - pitch_randomness, 1 + pitch_randomness)
	player.play()
