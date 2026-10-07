class_name ChickenNpc extends Npc

enum Action {NONE, PECKING, FLYING, LAYING_EGG, ECSTATIC, WALKING, RUNNING, FOLLOWING}

const ANIMATIONS = {
	Action.NONE: "idle_with_legs",
	Action.WALKING: "move_with_legs",
	Action.RUNNING: "move_and_peck_with_legs",
	Action.PECKING: "peck_with_legs",
	Action.FLYING: "fly",
	Action.LAYING_EGG: "lay_egg_short",
	Action.ECSTATIC: "ecstatic",
	Action.FOLLOWING: "move_with_legs"
}

var CHOREOGRAPHIES = {
	Action.FLYING: [Action.WALKING, Action.RUNNING, Action.FLYING]
}

## Which action is capable of performing
@export var main_action: Action
## Faces right (true) or left (false)
@export var faces_right: bool
## In px/s
@export var move_speed: int = 80
## In px/s
@export var run_speed: int = 150
## Vertical impulse for flying (px/s)
@export var jump_max_impulse: float = 5.0
## Gravity modifier, the higher the more gravity
@export var gravity_factor: float = 0.02
## Max height flying
@export var max_height: float = 20.0
## Time between actions
@export var time_between_actions: float = 4.0
## Use this to spawn the chicken in a different position where its action happens.
## Will move there before executing the action
@export var spawning_offset: Vector2 = Vector2.ZERO
## Set this to true to follow player after encountering this chicken
@export var follow_player := false

@onready var body := $Body
@onready var sprite := $Body/Sprite
@onready var wings := $Body/Wings
@onready var eyes := $Body/Eyes
@onready var next_action_timer := $NextActionTimer
@onready var visible_on_screen := $VisibleOnScreenNotifier2D

var z_velocity: float # For jumping/flying
var z_offset: float # Distance from the floor when flying
var action: Action
var choreography: Array = []
var action_position: Vector2 # Where the action happens. See spawning_offset variable
var spawning_position: Vector2 # Where the chicken spawns. See spawning_offset variable
var player_chicken: Chicken # Used to follow it

func _ready() -> void:
	action_position = global_position
	spawning_position = global_position + spawning_offset
	global_position = spawning_position
	face_right(faces_right)
	next_action_timer.wait_time = time_between_actions
	
func _physics_process(delta: float) -> void:
	manage_velocity(delta)
	face_move_direction()
	if velocity != Vector2.ZERO:
		move_and_slide()
	
func manage_velocity(delta: float):		
	if is_following():
		velocity = global_position.direction_to(player_chicken.global_position) * move_speed
		return
	if is_flying():
		z_velocity += get_gravity().y * gravity_factor * delta
		z_offset += z_velocity
		z_offset = max(-max_height, z_offset) # Max height is negative
		if z_offset > 0.0:
			land()
		body.position.y = z_offset	
	if has_action_position():		
		if visible_on_screen.is_on_screen() and not is_in_action_position():
			set_action(Action.WALKING)
			velocity = global_position.direction_to(action_position) * move_speed
		elif not visible_on_screen.is_on_screen() and not is_in_spawning_position():
			set_action(Action.WALKING)
			velocity = global_position.direction_to(spawning_position) * move_speed
		elif is_in_action_position() and not is_idle() and action != main_action:
			set_action(Action.NONE)
			velocity = Vector2.ZERO
	if is_idle():
		velocity = Vector2.ZERO
		
func face_move_direction():
	if is_moving():
		if velocity.x > 0:
			face_right(true)
		elif velocity.x < 0:
			face_right(false)
		
func face_right(right := true):
	body.scale.x = 1 if right else -1
	
func do_main_action():
	var next_action = main_action
	if not choreography.is_empty():
		next_action = choreography.pop_front()
	elif main_action in CHOREOGRAPHIES.keys():		
		choreography.append_array(CHOREOGRAPHIES.get(main_action))
		next_action = choreography.pop_front()
		turn()
		
	set_action(next_action)	

func set_action(new_action: Action):
	action = new_action
	var animation = ANIMATIONS.get(action)
	if animation != null:
		sprite.play(animation)
	eyes.visible = is_ecstatic()	
	match action:
		Action.WALKING:
			move()
		Action.RUNNING:
			move(true)
		Action.FLYING:
			fly()
	next_action_timer.start()

func _on_sprite_animation_finished() -> void:
	match action:
		Action.LAYING_EGG:
			lay_egg()
	set_action(Action.NONE)
	next_action_timer.start()
	
func move(run := false):
	velocity.x = run_speed if run else move_speed
	if not faces_right:
		velocity.x *= -1
	
func lay_egg():
	if visible_on_screen.is_on_screen():
		SignalBus.npc_lay_egg.emit(global_position)			
		SignalBus.play_chicken_sound.emit(SoundManager.ChickenSound.LAY_EGG)
		
func fly() -> void:
	wings.show()
	wings.play("default")
	z_velocity = -jump_max_impulse
	z_offset = -0.01
	
func land():
	z_offset = 0.0
	body.position.y = z_offset
	velocity = Vector2.ZERO
	wings.hide()
	set_action(Action.NONE)
	next_action_timer.start()
	
func turn():
	faces_right = not faces_right
	
func is_moving() -> bool: return velocity != Vector2.ZERO	
func is_idle() -> bool: return Action.NONE == action
func is_ecstatic() -> bool: return Action.ECSTATIC == action
func is_flying() -> bool: return Action.FLYING == action
func is_following() -> bool: return Action.FOLLOWING == action
func has_action_position() -> bool: return spawning_offset != Vector2.ZERO
func is_in_action_position() -> bool: return global_position.distance_to(action_position) < 2
func is_in_spawning_position() -> bool: return global_position.distance_to(spawning_position) < 2

func _on_next_action_timer_timeout() -> void:
	if is_flying():
		return # It will do something when lands
	do_main_action()

func _on_interaction_area_body_entered(body: Node2D) -> void:
	if not follow_player:
		return		
	if body is Chicken:
		if player_chicken == null:
			player_chicken = body
		set_action(Action.NONE)

func _on_interaction_area_body_exited(body: Node2D) -> void:
	if body is Chicken and player_chicken:
		set_action(Action.FOLLOWING)
