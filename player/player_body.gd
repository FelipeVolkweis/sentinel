extends CharacterBody3D

@export var movement_speed: float = 5.0
@export var jump_speed: float = 5.0

@export var jump_input: GUIDEAction
@export var move_input: GUIDEAction
@export var look_input: GUIDEAction

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
	
	
func _process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	move_and_slide()
