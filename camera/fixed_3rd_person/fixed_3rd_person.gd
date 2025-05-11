extends Node3D

@onready var pitch_node = $Yaw/Pitch
@onready var camera = $Yaw/Pitch/SpringArm3D/Camera3D

@export var pitch_input: GUIDEAction

@export var pitch_limit_min := -40.0 
@export var pitch_limit_max := 50.0  

var pitch = 0.0

func _process(delta: float) -> void:
	pitch = clamp(pitch + pitch_input.value_axis_1d, pitch_limit_min, pitch_limit_max)
	pitch_node.rotation_degrees.x = pitch
