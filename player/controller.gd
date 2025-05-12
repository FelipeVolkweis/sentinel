class_name Controller
extends Node


@onready var player := $".."

@export var regular_3rd_person: GUIDEMappingContext

@export var jump_input: GUIDEAction
@export var move_input: GUIDEAction
@export var yaw_input: GUIDEAction
@export var sprint_input: GUIDEAction
@export var walk_input: GUIDEAction
@export var camera_toggle_input: GUIDEAction

@export var state_chart: StateChart


enum MovementType {
	FIXED, FREE
}
var _movement_type := MovementType.FREE

var moving := false
var airborne := false
var grounded := false
var sprinting := false
var walking := false


func _ready() -> void:
	GUIDE.enable_mapping_context(regular_3rd_person)
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	_ready_state_chart()


func _ready_state_chart() -> void:
	state_chart.set_expression_property.call_deferred("moving", false)
	state_chart.set_expression_property.call_deferred("sprinting", false)
	state_chart.set_expression_property.call_deferred("walking", false)
	state_chart.set_expression_property.call_deferred("player", player)


func _process(delta: float) -> void:
	moving = move_input.value_axis_3d.normalized() != Vector3.ZERO
	state_chart.set_expression_property("moving", moving)
	
	if jump_input.is_triggered():
		state_chart.send_event("jump_input")

	sprinting = sprint_input.is_triggered()
	walking = walk_input.is_triggered()
	state_chart.set_expression_property("sprinting", sprinting)
	state_chart.set_expression_property("walking", walking)
	state_chart.set_expression_property("player", player)
			
	_camera_input_handler()


func _camera_input_handler():
	if camera_toggle_input.is_triggered():
		_movement_type = (_movement_type + 1) % MovementType.size()
		player.camera_config.update_yaw(player.visuals.rotation_degrees.y)
		
		match _movement_type:
			MovementType.FREE:
				player.camera_config.enable_free_camera()
			MovementType.FIXED:
				player.camera_config.enable_fixed_camera()


func get_movement_type() -> MovementType:
	return _movement_type


func is_free_movement_type() -> bool:
	return get_movement_type() == MovementType.FREE


func is_fixed_movement_type() -> bool:
	return get_movement_type() == MovementType.FIXED


func get_input_direction() -> Vector3:
	return move_input.value_axis_3d


func get_free_move_direction() -> Vector3:
	var input_dir = get_input_direction()
	var camera_basis = player.camera.global_transform.basis

	var forward = camera_basis.z
	var right = camera_basis.x
	forward.y = 0
	right.y = 0
	forward = forward.normalized()
	right = right.normalized()
	
	var direction = (right * input_dir.x + forward * input_dir.z).normalized()
	return direction
