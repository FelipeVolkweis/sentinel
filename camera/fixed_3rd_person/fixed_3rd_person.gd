class_name PlayerCamera
extends Node3D

@export var follow: Node3D
@export var active: bool:
	set(value):
		active = value
		_refresh()
@export var rotate_player_camera: GUIDEAction

@onready var _camera_arm: Node3D = %FixedCameraArm
@onready var _player_camera = %FixedPlayerCamera

func _ready():
	_refresh()
	
func _process(delta: float) -> void:
	_camera_arm.rotation_degrees.x = clamp(_camera_arm.rotation_degrees.x + rotate_player_camera.value_axis_1d, -90, 0)
	if is_instance_valid(follow):
		transform = follow.transform

func _refresh():
	if not is_instance_valid(_player_camera):
		return
	_player_camera.current = active
