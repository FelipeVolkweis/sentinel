extends CharacterBody3D

@export var sprinting_speed: float = 6.0
@export var walking_speed: float = 1.0
@export var jogging_speed: float = 4.0
@export var movement_acceleration: float = 25.0

@export var rotation_speed: float = 8.0
@export var jump_speed: float = 10.0
@export var deceleration: float = 15.0
@export var air_control: float = 1.0

@onready var visuals: Node3D = $View

@onready var camera = $Camera/Yaw/Pitch/SpringArm3D/Camera3D
@onready var camera_config = $Camera

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var current_speed: float = walking_speed


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= 2.25 * gravity * delta
		
	move_and_slide()
