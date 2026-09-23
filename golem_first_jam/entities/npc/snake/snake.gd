class_name Snake extends Npc

enum Action {ALERT, SEARCHING_EGG, EATING_EGG, GOING_BACK}

const ANIMATIONS = {
	Action.ALERT: "default",
	Action.SEARCHING_EGG: "move",
	Action.EATING_EGG: "eat",
	Action.GOING_BACK: "move",
}

## Movement speed in px/s
@export var speed: float = 50.0
## Time (s) that the snake takes to eat the egg
@export var time_to_eat_egg: float = 3.0

var action := Action.ALERT
var starting_position: Vector2
var target_position: Vector2

@onready var sprite := $Sprite
@onready var snake_sound := $SnakeHiss
@onready var eat_egg_timer := $EatEggTimer

func _ready() -> void:
	starting_position = global_position
	eat_egg_timer.wait_time = time_to_eat_egg

func _process(delta: float) -> void:
	if is_moving():
		var next_position = position.move_toward(target_position, delta * speed)
		position = next_position
		if target_position != starting_position and target_position.distance_to(next_position) < 4.0:
			eat_egg()

func _on_scare_area_body_entered(body: Node2D) -> void:
	if is_instance_of(body, Chicken):
		SignalBus.scare_chicken.emit()
		if not snake_sound.playing:
			sprite.play("hiss")
			snake_sound.play()

func go_to_egg(egg_position: Vector2):
	set_action(Action.SEARCHING_EGG)
	target_position = egg_position
	
func eat_egg():
	eat_egg_timer.start()
	set_action(Action.EATING_EGG)
	SignalBus.destroy_egg.emit(target_position)
	
func _on_eat_egg_timer_timeout() -> void:
	go_home()
	
func go_home():
	set_action(Action.GOING_BACK)
	target_position = starting_position
	
func set_action(new_action: Action):
	action = new_action
	var animation = ANIMATIONS.get(action)
	sprite.play(animation)
	
func is_moving() -> bool: return action in [Action.SEARCHING_EGG, Action.GOING_BACK]

func _on_sprite_animation_finished() -> void:
	set_action(Action.ALERT)
