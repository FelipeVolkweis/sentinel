extends Node3D


@onready var animation_tree := $AnimationTree
@onready var animation_state_machine = animation_tree.get("parameters/playback")
@onready var animator := $PlayerModel/AnimationPlayer


func _on_idling_state_entered() -> void:
	animation_state_machine.travel("Idle")


func _on_walking_state_entered() -> void:
	animation_state_machine.travel("Walk")


func _on_jumping_state_entered() -> void:
	animation_state_machine.travel("Jump_Start")


func _on_falling_state_entered() -> void:
	animation_state_machine.travel("Jump")


func _on_to_grounded_taken() -> void:
	animation_state_machine.travel("Jump_Land")
