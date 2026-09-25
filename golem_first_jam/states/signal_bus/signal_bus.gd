extends Node

# Global signal router (autoload). Entities/handlers emit here, managers listen.

signal dumb_thing_happened(message: String)

# GAME STATUS
signal toggle_game_pause(paused: bool)
signal start_game_time()
signal pause_game_time()
signal resume_game_time()
signal game_time_over()
signal add_node_to_canvas(node: Node2D) # Add to static canvas, always on camera
signal enter_ecstasy()

# CAMERA
signal follow_object(node: Node2D)

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
signal give_item_to_chicken(chicken: Chicken, item: PickableEntity)
signal take_item_from_chicken(chicken: Chicken) # Makes the chicken drop what it carries
signal chicken_drops_item(chicken: Chicken, item: PickableEntity) # Someone may claim the item before it falls
signal chicken_pecks_nothing(chicken: Chicken) # Nothing around to pick, someone may hand something over

 # PLACEABLES
signal chicken_entered_placeable(placeable: Placeable)
signal chicken_exited_placeable(placeable: Placeable)

# POLLEY DOORS
signal polley_door_opened(object: PickableEntity)
signal polley_door_closed(object: PickableEntity)

# POLLEY UPS
signal polley_up_activated(polley_up: PolleyUp)
signal polley_up_deactivated(polley_up: PolleyUp)

# EGGS
signal destroy_egg(egg_position: Vector2)
signal egg_in_hotspot(egg: Egg)
signal egg_fried(egg: Egg)

# L SHAPED BUILDINGS
signal ladder_enabled()
signal chicken_uses_chimney(target_position: Vector2)
signal chicken_lays_egg_on_chimney()

# SOUND
signal set_sounds_volume(value: float)
signal set_music_volume(value: float)
signal play_chicken_sound(sound_id: SoundManager.ChickenSound)
signal play_item_sound(sound_id: SoundManager.ItemSound)
