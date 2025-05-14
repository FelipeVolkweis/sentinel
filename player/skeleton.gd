extends Skeleton3D

@onready var right_downcast := $RightDowncast
@onready var left_downcast := $LeftDowncast
@onready var ik := $GodotIK
@onready var right_effector := $GodotIK/RightFootEffector
@onready var left_effector := $GodotIK/LeftFootEffector

@export var foot_offset: float = 0.05  # distância do chão até a sola do pé


func _ready():
	right_effector.active = true
	left_effector.active = true

	right_effector.bone_idx = find_bone("RightFoot")
	left_effector.bone_idx = find_bone("LeftFoot")

	right_effector.chain_length = 3
	left_effector.chain_length = 3

	right_effector.transform_mode = GodotIKEffector.POSITION_ONLY
	left_effector.transform_mode = GodotIKEffector.POSITION_ONLY


func _physics_process(delta):
	_update_effector(right_downcast, right_effector, Color.BLUE)
	_update_effector(left_downcast, left_effector, Color.GREEN)


func _update_effector(downcast: RayCast3D, effector: GodotIKEffector, color: Color = Color.RED):
	if downcast.is_colliding():
		var collision_point = downcast.get_collision_point()
		var collision_normal = downcast.get_collision_normal()
		var up = collision_normal.normalized()

		var forward = -global_transform.basis.z.normalized()
		forward = (forward - up * forward.dot(up)).normalized()
		var new_basis = Basis().looking_at(forward, up)

		var new_transform = effector.transform
		new_transform.origin = collision_point + up * foot_offset
		new_transform.basis = new_basis
		effector.transform = new_transform
