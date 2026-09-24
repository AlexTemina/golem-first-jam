class_name ChickenNpc extends Npc

enum Action {NONE, PECKING, FLYING, LAYING_EGG, ECSTATIC}

const ANIMATIONS = {
	Action.NONE: "idle_with_legs",
	Action.PECKING: "peck_with_legs",
	Action.FLYING: "fly",
	Action.LAYING_EGG: "lay_egg_short",
	Action.ECSTATIC: "ecstatic",
}

## Which action is capable of performing
@export var main_action: Action
## Faces right (true) or left (false)
@export var faces_right: bool
## In px/s
@export var run_speed: int = 150
## How many times you have to push during the quick press timer to fly (see time_to_quick_push)
@export var pushes_to_fly: int = 3
## Vertical impulse for flying (px/s)
@export var jump_max_impulse: float = 5.0
## Gravity modifier, the higher the more gravity
@export var gravity_factor: float = 0.02
## Max height flying
@export var max_height: float = 20.0

@onready var body := $Body
@onready var sprite := $Body/Sprite
@onready var wings := $Body/Wings
@onready var eyes := $Body/Eyes
@onready var next_action_timer := $NextActionTimer
@onready var visible_on_screen := $VisibleOnScreenNotifier2D

var z_velocity: float # For jumping/flying
var z_offset: float # Distance from the floor when flying

var action: Action

func _ready() -> void:
	face_right(faces_right)
	
func _physics_process(delta: float) -> void:
	manage_velocity(delta)
	face_move_direction()
	move_and_slide()
	
func manage_velocity(delta: float):		
	if is_flying():
		z_velocity += get_gravity().y * gravity_factor * delta
		z_offset += z_velocity
		z_offset = max(-max_height, z_offset) # Max height is negative
		print(z_offset)
		if z_offset > 0.0:
			land()
		body.position.y = z_offset
		
func face_move_direction():
	if is_moving():
		if velocity.x > 0:
			face_right(true)
		elif velocity.x < 0:
			face_right(false)
		
func face_right(right := true):
	body.scale.x = 1 if right else -1
	
func do_main_action():
	set_action(main_action)	
	match main_action:
		Action.FLYING:
			fly()

func set_action(new_action: Action):
	action = new_action
	var animation = ANIMATIONS.get(action)
	if animation != null:
		sprite.play(animation)
	eyes.visible = is_ecstatic()

func _on_sprite_animation_finished() -> void:
	match action:
		Action.LAYING_EGG:
			lay_egg()
	set_action(Action.NONE)
	next_action_timer.start()
	
func lay_egg():
	if visible_on_screen.is_on_screen():
		SignalBus.npc_lay_egg.emit(global_position)			
		SignalBus.play_chicken_sound.emit(SoundManager.ChickenSound.LAY_EGG)
		
func fly() -> void:
	set_action(Action.FLYING)
	wings.show()
	wings.play("default")
	z_velocity = -jump_max_impulse
	z_offset = -0.01
	
func land():
	z_offset = 0.0
	body.position.y = z_offset
	wings.hide()
	set_action(Action.NONE)
	next_action_timer.start()
	
func is_moving() -> bool: return velocity != Vector2.ZERO	
func is_idle() -> bool: return Action.NONE == action
func is_ecstatic() -> bool: return Action.ECSTATIC == action
func is_flying() -> bool: return Action.FLYING == action

func _on_next_action_timer_timeout() -> void:
	do_main_action()
