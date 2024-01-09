extends StateMachine

func _input(event: InputEvent):
	current_state.state_input(event)

#func _physics_process(delta):
	#super._physics_process(delta)
	#print(current_state)
