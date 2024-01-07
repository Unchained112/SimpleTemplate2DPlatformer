extends StateMachine

func _input(event: InputEvent):
	current_state.state_input(event)
