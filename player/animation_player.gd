class_name Animator
extends AnimationPlayer

var jump_animations := {
	"jump_land": "Jump_B/Jump_Land_B",
	"jump_start": "Jump_B/Jump_Start_B",
	"jump_loop": "Jump_B/Jump_Loop_B"
}

var movement_animations := {
	"idle": "AnimationLibrary_Godot_Standard/Idle",
	"jog": "Jog_Root/Jog_Root",
	"walk": "Walk_Root/Walk_Root",
	"sprint": "Dash_Root/Dash_Root"
}

var _8way_jog := {
	"jog_front": "Jog_Root/Jog_Root",
	"jog_front_left": "Jog_Root/Jog_Front_L_Root",
	"jog_front_left_45": "Jog_Root/Jog_Front_L45_Root",
	"jog_front_right": "Jog_Root/Jog_Front_R_Root",
	"jog_front_right_45": "Jog_Root/Jog_Front_R45_Root",
	"jog_back": "Jog_Root/Jog_Back_Root",
	"jog_back_left": "Jog_Root/Jog_Back_L_Root",
	"jog_back_left_45": "Jog_Root/Jog_Back_L45_Root",
	"jog_back_right": "Jog_Root/Jog_Back_R_Root",
	"jog_back_right_45": "Jog_Root/Jog_Back_R45_Root",
	"jog_center": "AnimationLibrary_Godot_Standard/Idle"
}

var animations: Dictionary = {}
var _last_8way_input := Vector2.ZERO

func _ready() -> void:
	for key in _8way_jog:
		movement_animations[key] = _8way_jog[key]
	for key in movement_animations:
		animations[key] = movement_animations[key]
	for key in jump_animations:
		animations[key] = jump_animations[key]
	
	configure_blending_transitions()


func reset_8way():
	_last_8way_input = Vector2.ZERO


func animate_8way(animation_name: String, input: Vector2) -> void:
	if _last_8way_input == input:
		return
		
	_last_8way_input = input
	if input == Vector2(0, 1):
		animate(animation_name + "_front")
	elif input == Vector2(-1, 1):
		animate(animation_name + "_front_left_45")
	elif input == Vector2(-1, 0):
		animate(animation_name + "_back_left")
	elif input == Vector2(-1, -1):
		animate(animation_name + "_back_left_45")
	elif input == Vector2(0, -1):
		animate(animation_name + "_back")
	elif input == Vector2(1, -1):
		animate(animation_name + "_back_right_45")
	elif input == Vector2(1, 0):
		animate(animation_name + "_back_right")
	elif input == Vector2(1, 1):
		animate(animation_name + "_front_right_45")
	else:
		animate(animation_name + "_center")


func animate(animation_name: String) -> void:
	if animations.has(animation_name):
		print("playing: ", animations[animation_name] )
		play(animations[animation_name])
	else:
		push_error("Animation not found: " + animation_name)


func configure_blending_transitions() -> void:
	configure_many_to_many_blending_transitions(movement_animations, 0.25)
	set_blend_time(jump_animations["jump_start"], jump_animations["jump_loop"], 0.1)
	set_blend_time(jump_animations["jump_loop"], jump_animations["jump_land"], 0.33)
	configure_one_to_many_blending_transitions(jump_animations["jump_land"], movement_animations, 0.2)
	configure_many_to_one_blending_transitions(movement_animations, jump_animations["jump_start"], 0.1)
	configure_many_to_one_blending_transitions(movement_animations, jump_animations["jump_loop"], 0.1)


func configure_many_to_many_blending_transitions(animations_dict: Dictionary, force: float) -> void:
	for a in animations_dict:
		for b in animations_dict:
			if a == b: 
				continue
			set_blend_time(animations_dict[a], animations_dict[b], force)


func configure_one_to_many_blending_transitions(from_anim: String, to_animations: Dictionary, force: float) -> void:
	for key in to_animations:
		var to_anim = to_animations[key]
		if from_anim == to_anim:
			continue
		set_blend_time(from_anim, to_anim, force)


func configure_many_to_one_blending_transitions(from_animations: Dictionary, to_anim: String, force: float) -> void:
	for key in from_animations:
		var from_anim = from_animations[key]
		if from_anim == to_anim:
			continue
		set_blend_time(from_anim, to_anim, force)
