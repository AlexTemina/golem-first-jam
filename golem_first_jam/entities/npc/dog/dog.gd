class_name Dog extends Npc

enum State {ALERT, SEARCHING_EGG, EATING_EGG, GOING_BACK}

## Movement speed in px/s
@export var speed: float = 50.0
## Time (s) that the dog takes to eat the egg
@export var time_to_eat_egg: float = 10.0

var state := State.ALERT
var starting_position: Vector2
var target_position: Vector2

@onready var dog_sound := $DogBark
@onready var eat_egg_timer := $EatEggTimer

func _ready() -> void:
	starting_position = position
	eat_egg_timer.wait_time = time_to_eat_egg

func _process(delta: float) -> void:
	if state in [State.SEARCHING_EGG, State.GOING_BACK]:
		var next_position = position.move_toward(target_position, delta * speed)
		position = next_position
		if target_position.distance_to(next_position) < 4.0:
			eat_egg()

func _on_scare_area_body_entered(body: Node2D) -> void:
	if is_instance_of(body, Chicken):
		SignalBus.scare_chicken.emit()
		if not dog_sound.playing:
			dog_sound.pitch_scale = randf_range(0.9, 1.05)
			dog_sound.play()

func go_to_egg(egg_position: Vector2):
	state = State.SEARCHING_EGG
	target_position = egg_position
	
func eat_egg():
	eat_egg_timer.start()
	state = State.EATING_EGG
	SignalBus.destroy_egg.emit(target_position)
	
func _on_eat_egg_timer_timeout() -> void:
	SignalBus.resume_game_time.emit()
	go_home()
	
func go_home():
	state = State.GOING_BACK
	target_position = starting_position
