extends CharacterBody3D

@export var sprinting_speed: float = 6.0
@export var walking_speed: float = 1.0
@export var jogging_speed: float = 4.0
@export var movement_acceleration: float = 25.0

@export var rotation_speed: float = 8.0
@export var jump_speed: float = 8.0
@export var deceleration: float = 15.0
@export var air_control: float = 1.0

@export var regular_3rd_person: GUIDEMappingContext

@export var jump_input: GUIDEAction
@export var move_input: GUIDEAction
@export var look_input: GUIDEAction
@export var run_input: GUIDEAction
@export var walk_input: GUIDEAction
@export var camera_toggle_input: GUIDEAction

@onready var visuals: Node3D = $View

@onready var free_camera = $Camera/Free3rdPerson/Yaw/Pitch/SpringArm3D/Camera3D
@onready var fixed_camera = $Camera/Fixed3rdPerson/Yaw/Pitch/SpringArm3D/Camera3D
@onready var camera = free_camera
var camera_type = CameraType.FREE
enum CameraType {
	FIXED, FREE
}

@onready var state_chart = $StateChart

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var current_speed: float = walking_speed

func _ready() -> void:
	fixed_camera.current = false
	GUIDE.enable_mapping_context(regular_3rd_person)
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= 2.25 * gravity * delta
		
	move_and_slide()
