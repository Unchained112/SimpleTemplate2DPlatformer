extends Node

class_name  State

var character: CharacterBody2D
var animation_tree: AnimationTree
var anime_state_machine: AnimationNodeStateMachinePlayback
var next_state: State

func setup(_character: CharacterBody2D,
		   _anime_state_machine: AnimationNodeStateMachinePlayback,
		   _animation_tree: AnimationTree):
	character = _character
	anime_state_machine = _anime_state_machine
	animation_tree = _animation_tree

func on_state_enter():
	pass

func on_state_exit():
	pass

@warning_ignore("unused_parameter")
func state_process(delta):
	pass

@warning_ignore("unused_parameter")
func state_input(event: InputEvent):
	pass
