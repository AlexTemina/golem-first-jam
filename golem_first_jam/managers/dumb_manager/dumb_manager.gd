extends Node
class_name DumbManager

# Example manager: owns a DumbEntity, listens to SignalBus, prints on the event.

@onready var dumb_entity: DumbEntity = $DumbEntity

func _ready() -> void:
	SignalBus.dumb_thing_happened.connect(_on_dumb_thing_happened)
	dumb_entity.trigger()

func _on_dumb_thing_happened(message: String) -> void:
	print("DumbManager heard: ", message)
