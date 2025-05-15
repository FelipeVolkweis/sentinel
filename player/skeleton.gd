extends Skeleton3D

@onready var right_downcast := $RightFootAttachment/RightDowncast
@onready var left_downcast := $LeftFootAttachment/LeftDowncast
@onready var ik := $GodotIK
@onready var right_effector := $GodotIK/RightFootEffector
@onready var right_pole := $GodotIK/RightFootEffector/RightPoleBoneConstraint
@onready var left_effector := $GodotIK/LeftFootEffector
@onready var left_pole := $GodotIK/LeftFootEffector/LeftPoleBoneConstraint

@export var foot_offset: float = 0.15 # distância do chão até a sola do pé


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
	ik.influence = 0
	_update_effector(right_downcast, right_effector)
	_update_effector(left_downcast, left_effector)


var previous_positions := {}

func _update_effector(downcast: RayCast3D, effector: GodotIKEffector):
	if downcast.is_colliding():
		var collision_point = downcast.get_collision_point()
		var collision_normal = downcast.get_collision_normal()
		var up = collision_normal.normalized()

		var target_position = collision_point + up * foot_offset
		var local_position = effector.to_local(target_position)

		var effector_name = effector.name
		var previous = previous_positions.get(effector_name, local_position)
		var smoothed = previous.lerp(local_position, 0.2) 
		previous_positions[effector_name] = smoothed

		var new_transform = effector.transform
		new_transform.origin = smoothed
		effector.transform = new_transform
