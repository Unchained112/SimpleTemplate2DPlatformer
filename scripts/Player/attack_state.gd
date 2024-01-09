extends State

@export var ground_state: State
@export var attack_move_speed: float = 20.0

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

func _on_animation_tree_animation_finished(_anim_name):
	if anime_state_machine.get_current_node() == "Attack-1":
		if attack_timer.is_stopped():
			next_state = ground_state
		else:
			anime_state_machine.travel("Attack-2")

	if anime_state_machine.get_current_node() == "Attack-2":
		if attack_timer.is_stopped():
			next_state = ground_state
		else:
			anime_state_machine.travel("Attack-3")

	if anime_state_machine.get_current_node() == "Attack-3":
		if attack_timer.is_stopped():
			next_state = ground_state
		else:
			anime_state_machine.travel("Attack-1")

func _on_animation_tree_animation_started(_anim_name):
	move_timer.start()
