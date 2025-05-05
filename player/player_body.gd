extends CharacterBody3D

@export var running_speed: float = 10.0
@export var walking_speed: float = 5.0
@export var rotation_speed: float = 5.0
@export var jump_speed: float = 5.0
@export var deceleration: float = 10.0

@export var regular_3rd_person: GUIDEMappingContext

@export var jump_input: GUIDEAction
@export var move_input: GUIDEAction
@export var look_input: GUIDEAction
@export var run_input: GUIDEAction
@export var camera_toggle_input: GUIDEAction

@onready var visuals: Node3D = $View

@onready var free_camera = $Camera/Free3rdPerson/Yaw/Pitch/SpringArm3D/Camera3D
@onready var fixed_camera = $Camera/Fixed3rdPerson
@onready var camera = free_camera

@onready var state_chart = $StateChart

var current_states: Dictionary = {}
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var current_speed: float = walking_speed

func _ready() -> void:
	GUIDE.enable_mapping_context(regular_3rd_person)
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= gravity * delta
		
	move_and_slide()	
