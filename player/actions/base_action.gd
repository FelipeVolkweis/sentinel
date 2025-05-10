class_name BaseAction
extends Node

@export var player: CharacterBody3D
@export var controller: Node
@export var animation_tree: AnimationTree
@export var animator: AnimationPlayer
@onready var animation_fsm = animation_tree["parameters/playback"]
