class_name InputHandler
extends RefCounted

@export var regular_mode:GUIDEMappingContext
@export var movement_speed: float = 5
@export var move: GUIDEAction
@export var look: GUIDEAction
@export var jump: GUIDEAction


func _init():
	GUIDE.enable_mapping_context(regular_mode)
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func handle_inputs():
	pass
