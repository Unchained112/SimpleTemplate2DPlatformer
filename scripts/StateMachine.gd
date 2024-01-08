extends Node

class_name StateMachine

@export var character: CharacterBody2D
@export var animation_tree: AnimationTree
@export var current_state: State

var states: Array[State]

@onready var anime_state_machine = animation_tree["parameters/playback"]

func _ready():
	for state in get_children():
		states.append(state)
		state.setup(character, anime_state_machine, animation_tree)

func _physics_process(delta):
	if current_state.next_state != null:
		switch_states(current_state.next_state)
	current_state.state_process(delta)

func switch_states(new_state: State):
	if(current_state != null):
		current_state.on_state_exit()
		current_state.next_state = null
	current_state = new_state
	current_state.on_state_enter()
