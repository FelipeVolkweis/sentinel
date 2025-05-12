extends BaseAction


func _on_landing_state_entered() -> void:
	animator.animate("jump_land")


func _on_landing_state_physics_processing(delta: float) -> void:
	player.stop(delta)
