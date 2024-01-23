extends State

@export var run_speed: float = 200.0

var face_dir: bool = false # false for right, true for left

func on_state_enter():
	anime_state_machine.travel("Idle")
	character.velocity.x = 0
	face_dir = character.sprite.flip_h

func state_process(_delta):
	# face target
	check_target()

func check_target():
	var relative_pos = character.target.position.x - character.position.x
	if relative_pos > 0 and face_dir == true:
		face_dir = false
		character.flip_face_dir(face_dir)
	elif relative_pos < 0 and face_dir == false:
		face_dir = true
		character.flip_face_dir(face_dir)

func bite():
	pass

func run_to_target():
	pass

func jump_acttack():
	pass


