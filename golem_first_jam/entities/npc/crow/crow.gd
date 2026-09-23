class_name Crow extends Npc

enum Action {IDLE, FLYING, INTERACTING, PECKING, ACROBACY}

const ANIMATIONS = {
	Action.IDLE: "default",
	Action.INTERACTING: "interact",
	Action.FLYING: "fly",
	Action.PECKING: "peck",
	Action.ACROBACY: "acrobacy"
}

## Flying speed in px/s
@export var flying_speed: float = 200.0
## If is teacher, touches the bell to show the user how to do it. Otherwise follows the bell sounds
@export var is_teacher: bool = false
## The bell that is attached to. If is teacher, it plays that bell.
@export var target_bell: Bell

@onready var sprite := $Sprite
@onready var croak_sound := $CroakSound
@onready var interaction_timer := $InteractionTimer
@onready var visible_checker := $VisibleOnScreenNotifier2D

var starting_position: Vector2
var action := Action.IDLE
var flight_target: Vector2

func _ready() -> void:		
	starting_position = self.global_position
		
func _process(delta: float) -> void:
	if is_flying():
		position = position.move_toward(flight_target, flying_speed * delta)
		if position.distance_to(flight_target) < 8:
			if flight_target == starting_position:
				set_action(Action.IDLE)
			else:
				interact()
	
func is_flying(): return action == Action.FLYING
	
func get_bell_id() -> Bell.Id:
	return target_bell.bell_id

func play_bell():
	set_action(Action.INTERACTING)
	target_bell.interact()

func _on_sprite_animation_finished() -> void:
	set_action(Action.IDLE)

func fly_to_bell():	
	fly_to(target_bell.get_attached_item_position())
	
func fly_to(target: Vector2):
	set_action(Action.FLYING)
	flight_target = target
	
func set_action(new_action: Action):
	action = new_action
	var animation = ANIMATIONS.get(action)
	if animation:
		sprite.play(animation)

func play_croak_sound():
	if not visible_checker.is_on_screen():
		return
	if not croak_sound.playing:
		croak_sound.play()
		
func interact():	
	play_croak_sound()
	interaction_timer.start()
	target_bell.interact_with_attached_item()
	action = Action.ACROBACY if target_bell.is_learning_bell() else Action.INTERACTING
	set_action(action)

func _on_interaction_timer_timeout() -> void:
	fly_to(starting_position)
