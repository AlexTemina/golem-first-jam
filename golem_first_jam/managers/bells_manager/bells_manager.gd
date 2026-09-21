class_name BellsManager extends Node

const SHORT_NOTE = '.'

# Just to be easily accessible
static var global_ring_sequence: String

## Dots and hyphens (short and long ring) to define the sequence to follow
@export var ring_sequence: String = '--..--'
## When this time is reached, the current sequence resets. In seconds
@export var max_time_between_rings: float = 2.0
## If time between rings is over this threshold (s), is considered long. Otherwise is short.
@export var long_ring_threshold: float = 0.5

@onready var reset_sequence_timer := $ResetSequenceTimer

var last_bell_id: Bell.Id
## List of timestamps of the active sequence
var current_sequence: Array[int] = []

func _ready() -> void:
	SignalBus.bell_ringed.connect(on_bell_ringed)
	reset_sequence_timer.wait_time = max_time_between_rings
	global_ring_sequence = ring_sequence
	
static func is_short_note(note: String):
	return SHORT_NOTE == note
	
func on_bell_ringed(bell_id: Bell.Id):
	last_bell_id = bell_id
	match bell_id:
		Bell.Id.CHICKEN_COUP_BELL:
			chicken_ringed()
			
func chicken_ringed():
	reset_sequence_timer.start()
	current_sequence.append(Time.get_ticks_msec())
	if current_sequence.size() == ring_sequence.length():
		check_current_sequence()
		clear_sequence()

func _on_reset_sequence_timer_timeout() -> void:
	clear_sequence()
	
func clear_sequence():
	current_sequence = []

func check_current_sequence():	
	for i in range(current_sequence.size() - 1):
		var ring_time = current_sequence[i]
		var next_ring_time = current_sequence[i + 1]
		var delay_between_rings = (next_ring_time - ring_time) / 1000.0
		var is_long_ring = delay_between_rings >= long_ring_threshold
		var is_long_expected = ring_sequence[i] != SHORT_NOTE
		if is_long_expected != is_long_ring:
			return
	
	print('Sequence completed!!')		
	SignalBus.bell_sequence_completed.emit(last_bell_id)
	
	
	
	
	
