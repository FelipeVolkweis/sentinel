extends CharacterBody3D

@export var regular_mode:GUIDEMappingContext
@export var movement_speed: float = 5
@export var move: GUIDEAction
@export var rotate: GUIDEAction
@export var gravity = -9.81

func _ready():
	GUIDE.enable_mapping_context(regular_mode)

func _process(delta: float) -> void:
	velocity = basis * move.value_axis_3d.normalized() * movement_speed
	rotation_degrees.y += rotate.value_axis_1d
	if not is_on_floor():
		velocity.y = gravity
	
	move_and_slide()
