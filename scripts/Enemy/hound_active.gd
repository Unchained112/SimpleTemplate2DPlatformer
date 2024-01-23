extends State

@export var run_speed: float = 200.0

func on_state_enter():
	anime_state_machine.travel("Idle")

func state_process(_delta):
	pass

func bite():
	pass

func run_to_target():
	pass

func jump_acttack():
	pass


