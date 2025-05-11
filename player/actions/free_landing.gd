extends FreeMovement


func _on_landing_state_entered() -> void:
	#animation_fsm.travel("Jump_Land")
	animator.animate("jump_land")


func _on_landing_state_physics_processing(delta: float) -> void:
	player.velocity.x = lerp(player.velocity.x, 0.0, player.deceleration * delta)
	player.velocity.z = lerp(player.velocity.z, 0.0, player.deceleration * delta)	
