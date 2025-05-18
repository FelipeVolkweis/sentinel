extends Skeleton3D

@onready var right_downcast := $RightDowncast
@onready var left_downcast := $LeftDowncast
@onready var ik := $GodotIK
@onready var right_effector := $GodotIK/RightFootEffector
@onready var right_pole := $GodotIK/RightFootEffector/RightPoleBoneConstraint
@onready var left_effector := $GodotIK/LeftFootEffector
@onready var left_pole := $GodotIK/LeftFootEffector/LeftPoleBoneConstraint

@export var foot_offset: float = 0.325
@export var rotation_offset_degrees := Vector3(0, 0, 0)  # Start with no offsets

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

	right_effector.transform_mode = GodotIKEffector.FULL_TRANSFORM
	left_effector.transform_mode = GodotIKEffector.FULL_TRANSFORM


func _physics_process(delta):
	_lock_effector_to_ground(right_downcast, right_effector)
	_lock_effector_to_ground(left_downcast, left_effector)


func _lock_effector_to_ground(downcast: RayCast3D, effector: GodotIKEffector):
	if downcast.is_colliding():
		var collision_point = downcast.get_collision_point()
		var collision_normal = downcast.get_collision_normal().normalized()
		
		# Position the foot
		effector.global_position = collision_point + (collision_normal * foot_offset)
		
		# Get stable forward direction from the skeleton, not the effector
		var character_forward = -global_transform.basis.z  # Assuming character faces -Z
		var foot_right = character_forward.cross(collision_normal).normalized()
		var foot_forward = collision_normal.cross(foot_right).normalized()
		
		# Create target basis with stable orientation
		var target_basis = Basis(
			foot_right,
			collision_normal,
			foot_forward
		).orthonormalized()
		
		# Apply only pitch/roll offsets (remove yaw from offsets)
		var pitch_roll_offset = Basis.from_euler(Vector3(
			deg_to_rad(rotation_offset_degrees.x),
			deg_to_rad(rotation_offset_degrees.y),
			deg_to_rad(rotation_offset_degrees.z)
		))
		
		# Combine rotations
		effector.global_transform.basis = (target_basis * pitch_roll_offset).orthonormalized()
