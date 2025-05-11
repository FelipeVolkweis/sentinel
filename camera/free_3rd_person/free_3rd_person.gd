extends Node3D


@onready var yaw_node = $Yaw
@onready var pitch_node = $Yaw/Pitch
@onready var camera = $Yaw/Pitch/SpringArm3D/Camera3D

@export var pitch_input: GUIDEAction
@export var yaw_input: GUIDEAction

@export var pitch_limit_min := -40.0 
@export var pitch_limit_max := 50.0  

var _yaw = 0.0
var _pitch = 0.0
var _use_free_camera := true


func enable_free_camera():
	_use_free_camera = true


func enable_fixed_camera():
	_use_free_camera = false


func update_yaw(new_yaw: float):
	_yaw = new_yaw


func _process(delta: float) -> void:
	if _use_free_camera:
		_yaw += yaw_input.value_axis_1d
	
	yaw_node.rotation_degrees.y = _yaw;
	_pitch = clamp(_pitch + pitch_input.value_axis_1d, pitch_limit_min, pitch_limit_max)
	pitch_node.rotation_degrees.x = _pitch
	
