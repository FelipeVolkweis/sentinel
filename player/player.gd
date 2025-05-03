extends Node3D

@export var regular_3rd_person: GUIDEMappingContext


func _ready() -> void:
	GUIDE.enable_mapping_context(regular_3rd_person)
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
