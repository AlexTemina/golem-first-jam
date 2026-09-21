extends Node

# Global signal router (autoload). Entities/handlers emit here, managers listen.

signal dumb_thing_happened(message: String)

# GAME STATUS
signal game_time_over()
signal add_node_to_canvas(node: Node2D) # Add to static canvas, always on camera
signal enter_ecstasy()

# CHICKEN
signal chicken_pecks(chicken: Chicken)
signal chicken_flies()
signal chicken_lands()
signal lay_egg(position: Vector2)
signal special_vision_toggled(on: bool)
signal chicken_crosses_road(chicken_position: Vector2)
signal chicken_jumps_in_tractor(chicken: Chicken)
signal chicken_is_released()
signal toggle_learning_spot(on: bool)

# NPCs
signal scare_chicken()
signal npc_lay_egg(egg_position: Vector2)
signal destroy_egg(egg_position: Vector2)
signal register_npc(npc: Node2D)

# OBSTACLES
signal enable_obstacles()
signal disable_obstacles()

# VEHICLES
signal launch_car()
signal tractor_started_moving()
signal tractor_crashed()

# PUSHABLE ITEMS
signal register_pushable(pushable: PushableEntity)
signal pushable_item_interacted(item: PushableEntity)
signal chicken_coup_door_opened()

# BELLS AND CROWS
signal bell_ringed(bell_id: Bell.Id)
signal bell_sequence_completed(bell_id: Bell.Id)
signal register_crow(crow: Crow)

# PICKABLE ITEMS
signal register_pickable(pickable: PickableEntity)
signal unregister_pickable(pickable: PickableEntity)

# SOUND
signal play_chicken_sound(sound_id: SoundManager.ChickenSound)
signal play_item_sound(sound_id: SoundManager.ItemSound)
