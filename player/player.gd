class_name Player
extends CharacterBody3D

@export var regular_mode:GUIDEMappingContext
@export var movement_speed: float = 5
@export var jump_speed: float = 8
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	GUIDE.enable_mapping_context(regular_mode)
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	move_and_slide()
