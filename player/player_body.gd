class_name PlayerBody
extends CharacterBody3D

@export var sprinting_speed: float = 6.0
@export var walking_speed: float = 1.0
@export var jogging_speed: float = 4.0
@export var movement_acceleration: float = 25.0

@export var rotation_speed: float = 8.0
@export var jump_speed: float = 10.0
@export var deceleration: float = 15.0
@export var air_control: float = 1.0

@onready var visuals: Node3D = $Model/Visuals/Rig

@onready var camera = $Camera/Yaw/Pitch/SpringArm3D/Camera3D
@onready var camera_config = $Camera

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var current_speed: float = walking_speed


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= 2.25 * gravity * delta
		
	move_and_slide()


func is_grounded() -> bool:
	return is_on_floor()


func is_airborne() -> bool:
	return !is_on_floor()


func move_to(direction: Vector3, speed: float, delta: float) -> void:
	velocity = velocity.move_toward(direction * speed, movement_acceleration * delta)
	

func rotate_to(direction: Vector3, delta: float) -> void:
	var target_rotation = atan2(direction.x, direction.z) - rotation.y + PI
	visuals.rotation.y = lerp_angle(visuals.rotation.y, target_rotation, rotation_speed * delta)


func rotate_by(degrees: float) -> void: 
	rotation_degrees.y += degrees


func stop(delta: float):
	velocity.x = lerp(velocity.x, 0.0, deceleration * delta)
	velocity.z = lerp(velocity.z, 0.0, deceleration * delta)


func jump() -> void:
	velocity.y = jump_speed


func air_strafe(direction: Vector3, delta: float) -> void:
	var current_velocity = Vector3(velocity.x, 0, velocity.z)
	var speed = max(current_velocity.length(), air_control / 2) 

	var new_direction = current_velocity.normalized().slerp(direction, air_control * delta)
	var adjusted_velocity = new_direction * speed
	velocity.x = adjusted_velocity.x
	velocity.z = adjusted_velocity.z
