class_name BusStop extends Prop

@onready var collision_box := $Area2D/CollisionShape2D
@onready var crash_sound := $BusStopCrash
@onready var animator := $Animator

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Tractor:		
		animator.play("crash")
		collision_box.disabled = true
		SignalBus.tractor_crashed.emit()
		crash_sound.play()


func _on_area_2d_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	if area.get_parent() is Tractor:		
		animator.play("crash")
		collision_box.disabled = true
		SignalBus.tractor_crashed.emit()
		crash_sound.play()
