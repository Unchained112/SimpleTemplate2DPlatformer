extends State

@export var walk_speed: float = 100.0
@export var active_state: State
@export var hit_state: State

var face_left: bool = false

@onready var walk_timer: Timer = $WalkTimer
@onready var wait_timer: Timer = $WaitTimer

func on_state_enter():
	anime_state_machine.travel("Run")
	walk_timer.start()

func on_state_exit():
	walk_timer.stop()
	wait_timer.stop()

func state_process(_delta):
	if character.is_idle:
		walk_around()
	else:
		next_state = active_state

func walk_around():
	if not walk_timer.is_stopped():
		if face_left:
			character.velocity.x = -walk_speed
		else:
			character.velocity.x = walk_speed
	else:
		character.velocity.x = 0

func filp_face_dir():
	face_left = !face_left
	character.flip_face_dir(face_left)

func _on_walk_timer_timeout():
	wait_timer.start()
	anime_state_machine.travel("Idle")

func _on_wait_timer_timeout():
	walk_timer.start()
	filp_face_dir()
	anime_state_machine.travel("Run")

