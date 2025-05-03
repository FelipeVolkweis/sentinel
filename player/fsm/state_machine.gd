class_name StateMachine
extends Node

@export var move_input: GUIDEAction
@export var look_input: GUIDEAction
@export var jump_input: GUIDEAction

var move_state: MoveState
var look_state: LookState
var jump_state: JumpState

var _current_state: State = null

func _init():
	_current_state = IdleState.new()

func change_state(new_state: State):
	if _current_state != null:
		_current_state.exit()
	
	_current_state = new_state
	_current_state.owner = owner
	_current_state.enter()
		
func _process(delta: float):
	_current_state.update(delta)
	
