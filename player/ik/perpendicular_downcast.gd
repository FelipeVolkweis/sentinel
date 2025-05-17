extends RayCast3D

@onready var skeleton: Skeleton3D = %Skeleton
@export var boneName: String
var _boneId: int
var Y_OFFSET = 0.3

func _ready() -> void:
	_boneId = skeleton.find_bone(boneName)


func _process(delta: float) -> void:
	var global_pose = skeleton.get_bone_global_pose(_boneId)
	position = global_pose.origin
	position.y += Y_OFFSET
	
