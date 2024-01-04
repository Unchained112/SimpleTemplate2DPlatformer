extends Node

class_name  State

var character: CharacterBody2D
var anime_state_machine: AnimationNodeStateMachinePlayback
var next_state: State

func setup(_character: CharacterBody2D,
		   _anime_state_machine: AnimationNodeStateMachinePlayback):
	character = _character
	anime_state_machine = _anime_state_machine

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
