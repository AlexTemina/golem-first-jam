extends Node
class_name DumbEntity

# Example entity: has zero visuals or logic, just emits a signal when told to.
# Entities never call managers/handlers/states directly — they only emit.

func trigger() -> void:
	SignalBus.dumb_thing_happened.emit("the dumb entity did a dumb thing")
