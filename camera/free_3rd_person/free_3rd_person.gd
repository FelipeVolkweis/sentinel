extends Node3D


@onready var yaw_node = $Yaw
@onready var pitch_node = $Yaw/Pitch
@onready var _camera_arm = $Yaw/Pitch/SpringArm3D
@onready var camera = $Yaw/Pitch/SpringArm3D/Camera3D

@export var pitch_input: GUIDEAction
@export var yaw_input: GUIDEAction

@export var pitch_limit_min := -60.0 
@export var pitch_limit_max := 60.0  

var yaw = 0.0
var pitch = 0.0


func _process(delta: float) -> void:
	yaw += yaw_input.value_axis_1d
	yaw_node.rotation_degrees.y = yaw;
	pitch = clamp(pitch + pitch_input.value_axis_1d, pitch_limit_min, pitch_limit_max)
	pitch_node.rotation_degrees.x = pitch
	
