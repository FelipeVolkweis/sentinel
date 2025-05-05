extends Node3D

@onready var animation_tree := $AnimationTree
@onready var animator := $PlayerModel/AnimationPlayer
@onready var state_machine = animation_tree["parameters/playback"]

func _on_idling_state_entered() -> void:
	state_machine.travel("Idle")


func _on_walking_state_entered() -> void:
	state_machine.travel("Walk")


func _on_jumping_state_entered() -> void:
	state_machine.travel("Jump_Start")


func _on_falling_state_entered() -> void:
	state_machine.travel("Jump")


func _on_landing_state_entered() -> void:
	state_machine.travel("Jump_Land")


func _on_running_state_entered() -> void:
	state_machine.travel("Sprint")


func _on_airborne_state_entered() -> void:
	state_machine.travel("Jump")
	
