extends BaseAction


func _on_falling_state_entered() -> void:
	animation_fsm.travel("Jump")
