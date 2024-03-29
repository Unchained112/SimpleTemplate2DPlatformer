extends State

@export var attack_move_speed: float = 10.0
@export var air_state: State

var attack_dir: bool = false # false for right, true for left

@onready var attack_timer: Timer = $AttackTimer
@onready var move_timer: Timer = $MoveTimer

func state_input(event: InputEvent):
	if event.is_action_pressed("attack"):
		attack_timer.start()

func state_process(_delta):
	attack_dir = character.sprite.flip_h
	if not move_timer.is_stopped():
		if attack_dir:
			character.velocity.x = -attack_move_speed
		else:
			character.velocity.x = attack_move_speed
	else:
		character.velocity.x = 0.0
	character.velocity.y = 0.0

func attack_return(anim_name: String, num: int):
	if anime_state_machine.get_current_node() == anim_name + str(num):
		if attack_timer.is_stopped():
			next_state = air_state
			next_state.is_air_attack = true
			anime_state_machine.travel("Fall")
		else:
			anime_state_machine.travel(anim_name + str((num%3) + 1))

func _on_animation_tree_animation_finished(_anim_name):
	attack_return("Air-attack-", 1)
	attack_return("Air-attack-", 2)
	attack_return("Air-attack-", 3)

func _on_animation_tree_animation_started(_anim_name):
	move_timer.start()
