class_name LowerHipsModifier
extends SkeletonModifier3D

@export var crouch_offset: float = 0.7
@export var blend_speed: float = 5.0

var current_offset := 0.0
var target_offset := 0.0


func _lower_bone(bone_name: String):
	var skeleton := get_skeleton()
	if !skeleton:
		return

	var bone_idx := skeleton.find_bone(bone_name)
	if bone_idx == -1:
		return

	# Example: always crouch, but could be controlled externally
	target_offset = crouch_offset
	current_offset = lerp(current_offset, target_offset, get_process_delta_time() * blend_speed)

	# Modify the *local* pose
	var pose := skeleton.get_bone_global_pose(bone_idx)
	pose.origin.y = current_offset
	skeleton.set_bone_global_pose(bone_idx, pose)
	

func _process_modification() -> void:
	_lower_bone("Hips")
	#_lower_bone("RightUpperLeg")
