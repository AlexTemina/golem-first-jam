class_name ChickenNpc extends Npc

enum Action {NONE, PECKING, FLYING, LAYING_EGG, ECSTATIC}

const ANIMATIONS = {
	Action.NONE: "idle",
	Action.PECKING: "peck",
	Action.FLYING: "fly",
	Action.LAYING_EGG: "lay_egg_short",
	Action.ECSTATIC: "ecstatic",
}

## Which action is capable of performing
@export var main_action: Action
## Face right (true) or left (false)
@export var face_right: bool

@onready var body := $Body
@onready var sprite := $Body/Sprite
@onready var next_action_timer := $NextActionTimer
@onready var visible_on_screen := $VisibleOnScreenNotifier2D

var action: Action

func _ready() -> void:
	body.scale.x = 1 if face_right else -1
	
func do_main_action():
	set_action(main_action)	

func set_action(new_action: Action):
	action = new_action
	var animation = ANIMATIONS.get(action)
	if animation != null:
		sprite.play(animation)

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
	
func is_idle() -> bool: return Action.NONE == action

func _on_next_action_timer_timeout() -> void:
	do_main_action()
