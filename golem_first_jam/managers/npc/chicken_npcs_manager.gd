class_name ChickenNpcsManager extends Node

var chickens: Array[ChickenNpc]

func _ready() -> void:
	SignalBus.register_npc.connect(on_register_npc)
	
func on_register_npc(npc: Node2D):
	if npc is ChickenNpc:
		var chicken_npc: ChickenNpc = npc
		chickens.append(chicken_npc)
		chicken_npc.do_main_action()

func _on_tick_timer_timeout() -> void:
	pass # execute_chicken_actions()
	
func execute_chicken_actions():
	for chicken in chickens:
		if chicken.is_idle():
			chicken.do_main_action()
