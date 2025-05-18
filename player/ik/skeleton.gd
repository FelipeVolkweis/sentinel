extends Skeleton3D

@onready var right_downcast := $RightDowncast
@onready var left_downcast := $LeftDowncast
@onready var left_ik := $LeftFootIK
@onready var right_ik := $RightFootIK
@onready var right_effector := $RightFootIK/RightFootEffector
@onready var right_pole := $RightFootIK/RightFootEffector/RightPoleBoneConstraint
@onready var left_effector := $LeftFootIK/LeftFootEffector
@onready var left_pole := $LeftFootIK/LeftFootEffector/LeftPoleBoneConstraint
@onready var debug := $"../../../../DebugVisualizer"

@export var foot_offset: float = 0.1
@export var rotation_offset_degrees := Vector3(-90, 0, 0)
@export var influence_threshold: float = 0.1
@export var influence_lerp_speed: float = 5.0
@export var smooth_basis: float = 2.0


func _ready():
	for effector in [left_effector, right_effector]:
		effector.active = true
		effector.chain_length = 3
		effector.transform_mode = GodotIKEffector.FULL_TRANSFORM

	right_effector.bone_idx = find_bone("RightFoot")
	left_effector.bone_idx = find_bone("LeftFoot")
	right_pole.bone_idx = find_bone("RightLowerLeg")
	left_pole.bone_idx = find_bone("LeftLowerLeg")


func _physics_process(delta):
	_process_foot(right_downcast, right_effector, right_ik, delta)
	_process_foot(left_downcast, left_effector, left_ik, delta)


func _process_foot(downcast: RayCast3D, effector: GodotIKEffector, ik: GodotIK, delta: float):
	var grounded = _is_foot_grounded(downcast, effector.bone_idx)
	var target: float
	if grounded:
		target = 1.0
	else:
		target = 0.0
	
	ik.influence = lerp(ik.influence, target, influence_lerp_speed * delta)
	if grounded:
		_lock_effector_to_ground(downcast, effector, delta)


func _is_foot_grounded(downcast: RayCast3D, bone_idx: int) -> bool:
	if not downcast.is_colliding():
		return false
	var collision_point = downcast.get_collision_point()
	var collision_normal = downcast.get_collision_normal().normalized()
	var bone_pos = get_bone_global_pose(bone_idx).origin
	var global_bone_pos: Vector3 = to_global(bone_pos)
	var dist = abs((global_bone_pos - collision_point).dot(collision_normal))
	#debug.plot_sphere(global_bone_pos, 0.05)
	return dist <= influence_threshold


func _lock_effector_to_ground(downcast: RayCast3D, effector: GodotIKEffector, delta: float):
	var collision_point = downcast.get_collision_point()
	var collision_normal = downcast.get_collision_normal().normalized()
	effector.global_position = collision_point + collision_normal * foot_offset

	var character_forward = -global_transform.basis.z
	var foot_right = character_forward.cross(collision_normal).normalized()
	var foot_forward = collision_normal.cross(foot_right).normalized()
	foot_right = -foot_right

	var target_basis = Basis(foot_right, collision_normal, foot_forward).orthonormalized()
	var pitch_roll_offset = Basis.from_euler(Vector3(
		deg_to_rad(rotation_offset_degrees.x),
		deg_to_rad(rotation_offset_degrees.y),
		deg_to_rad(rotation_offset_degrees.z)
	))
	
	var final_basis = (target_basis * pitch_roll_offset).orthonormalized()
	var current_basis = effector.global_transform.basis.orthonormalized()
	var q_current = current_basis.get_rotation_quaternion()
	var q_target  = final_basis.orthonormalized().get_rotation_quaternion()
	var t = clamp(smooth_basis * delta, 0, 1)
	var q_smooth = q_current.slerp(q_target, t)
	effector.global_transform.basis = Basis(q_smooth).orthonormalized()
