extends Node
class_name FSM

@export var initial_state: State
@export var player: CharacterBody3D

var _current_state: State
var states: Dictionary = {}


func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name] = child
			child.player = player
			child.parent_fsm = self
			print_debug("Adding " + child.name + " to " + name)
	change_state(initial_state)


func run(delta: float) -> void:
	if _current_state != null:
		_current_state.execute(delta)


func change_state(new_state: State):
	if _current_state:
		_current_state.exit()
	
	_current_state = new_state
	if _current_state:
		_current_state.enter()
