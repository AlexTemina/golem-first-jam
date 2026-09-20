class_name CrowsManager extends Node

## Time the teacher crow waits until playing next sequence
@export var time_between_sequences: float = 5.0

var crows: Array[Crow] = []
var teacher_crow: Crow
var sequence_index := 0

@onready var sequence_timer := $SequenceTimer

func _ready() -> void:
	SignalBus.register_npc.connect(register_npc)
	SignalBus.bell_sequence_completed.connect(on_bell_sequence_completed)
	
func init():
	play_sequence()
	
func register_npc(npc: Node2D):
	if npc is Crow:
		var crow: Crow = npc
		crows.append(crow)
		if crow.is_teacher:
			teacher_crow = crow
		
func play_sequence():
	sequence_index = 0
	play_next_note()

func _on_sequence_timer_timeout() -> void:
	if sequence_index == BellsManager.global_ring_sequence.length():
		sequence_index = 0
		sequence_timer.start(time_between_sequences)
		SignalBus.bell_sequence_completed.emit(teacher_crow.get_bell_id())
	else:
		play_next_note()
	
func play_next_note():
	var sequence = BellsManager.global_ring_sequence
	teacher_crow.play_bell()
	var first_note = sequence[sequence_index]
	sequence_index += 1
	sequence_timer.wait_time = 0.4 if BellsManager.is_short_note(first_note) else 1.0
	sequence_timer.start()
	
func on_bell_sequence_completed(bell_id: Bell.Id):
	for crow in crows:
		if crow.is_teacher:
			continue
		if crow.get_bell_id() == bell_id:
			crow.fly_to_bell()
