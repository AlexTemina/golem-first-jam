extends Node

# Global signal router (autoload). Entities/handlers emit here, managers listen.

signal dumb_thing_happened(message: String)

signal lay_egg(position: Vector2)

# SOUND
signal play_chicken_sound(sound_id: SoundManager.ChickenSound)
