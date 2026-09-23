class_name Npc extends CharacterBody2D

func init():
	SignalBus.register_npc.emit(self)
	# z_index = global_position.y
