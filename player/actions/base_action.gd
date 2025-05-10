class_name BaseAction
extends Node

@onready var player := $"../../.."
@onready var controller := $"../../../Controller"
@onready var animation_tree := $"../../Visuals/AnimationTree"
@onready var animator := $"../../Visuals/AnimationPlayer"
@onready var animation_fsm = animation_tree["parameters/playback"]

func move_to(speed: float, delta: float):
	if player.camera_type == player.CameraType.FREE:
		var direction = controller.get_free_move_direction()
		var target_rotation = atan2(direction.x, direction.z) - player.rotation.y + PI
		player.visuals.rotation.y = lerp_angle(player.visuals.rotation.y, target_rotation, player.rotation_speed * delta)
		player.velocity = player.velocity.move_toward(direction * speed, player.movement_acceleration * delta)
	elif player.camera_type == player.CameraType.FIXED:
		pass
		
