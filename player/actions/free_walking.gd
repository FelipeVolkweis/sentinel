extends FreeMovement


func _on_walking_state_physics_processing(delta: float) -> void:
	move_to(player.walking_speed, delta)


func _on_walking_state_entered() -> void:
	animation_fsm.travel("Walk")
