extends CharacterBody3D

@export var running_speed: float = 10.0
@export var walking_speed: float = 5.0
@export var rotation_speed: float = 5.0
@export var jump_speed: float = 5.0

@export var jump_input: GUIDEAction
@export var move_input: GUIDEAction
@export var look_input: GUIDEAction
@export var run_input: GUIDEAction
@export var camera_toggle_input: GUIDEAction

@onready var visuals: Node3D = $Visuals

@onready var free_camera = $Free3rdPerson/Yaw/Pitch/SpringArm3D/Camera3D
@onready var fixed_camera = $Fixed3rdPerson
@onready var camera = free_camera

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var current_speed: float = walking_speed
	
func _process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	move_and_slide()
