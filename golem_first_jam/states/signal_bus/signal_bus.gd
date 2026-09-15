extends Node

# Global signal router (autoload). Entities/handlers emit here, managers listen.

signal dumb_thing_happened(message: String)

# GAME STATUS
signal game_time_over()

# CHICKEN
signal chicken_pecks(chicken_position: Vector2)
signal chicken_flies()
signal chicken_lands()
signal lay_egg(position: Vector2)
signal special_vision_toggled(on: bool)

# NPCs
signal snake_scares()

# OBSTACLES
signal enable_obstacles()
signal disable_obstacles()

# PUSHABLE ITEMS
signal pushable_item_interacted(item: PushableEntity)
signal bell_ringed(bell_id: Bell.Id)
signal bell_sequence_completed(bell_id: Bell.Id)

# SOUND
signal play_chicken_sound(sound_id: SoundManager.ChickenSound)
