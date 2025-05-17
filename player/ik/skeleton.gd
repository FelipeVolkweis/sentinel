extends Skeleton3D

@onready var right_downcast := $RightDowncast
@onready var left_downcast := $LeftDowncast
@onready var ik := $GodotIK
@onready var right_effector := $GodotIK/RightFootEffector
@onready var right_pole := $GodotIK/RightFootEffector/RightPoleBoneConstraint
@onready var left_effector := $GodotIK/LeftFootEffector
@onready var left_pole := $GodotIK/LeftFootEffector/LeftPoleBoneConstraint

@export var foot_offset: float = 0.1

var cleanup = []

func _ready():
	right_effector.active = true
	left_effector.active = true
	right_pole.active = true
	left_pole.active = true

	right_effector.bone_idx = find_bone("RightFoot")
	left_effector.bone_idx = find_bone("LeftFoot")
	right_pole.bone_idx = find_bone("RightLowerLeg")
	left_pole.bone_idx = find_bone("LeftLowerLeg")
	
	right_effector.chain_length = 3
	left_effector.chain_length = 3

	right_effector.transform_mode = GodotIKEffector.PRESERVE_ROTATION
	left_effector.transform_mode = GodotIKEffector.PRESERVE_ROTATION


func _physics_process(delta):
	_lock_effector_to_ground(right_downcast, right_effector)
	_lock_effector_to_ground(left_downcast, left_effector)


func _lock_effector_to_ground(downcast: RayCast3D, effector: GodotIKEffector):
	if downcast.is_colliding():
		var collision_point = downcast.get_collision_point()
		var collision_normal = downcast.get_collision_normal().normalized()
		var target_position = collision_point + collision_normal * foot_offset

		effector.global_position = target_position
