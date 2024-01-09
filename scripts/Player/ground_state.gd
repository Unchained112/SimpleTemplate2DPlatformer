extends State

@export var jump_velocity: float = -500.0
@export var dash_scale: float = 2.0
@export var air_state: State
@export var attack_state: State

var direction: float = 0.0;

func on_state_enter():
	anime_state_machine.travel("Move")

func state_process(_delta):
	if not character.is_on_floor():
		next_state = air_state
		anime_state_machine.travel("Fall")

	direction = Input.get_axis("move_left", "move_right")
	character.velocity.x = character.speed * direction
	if anime_state_machine.get_current_node() == "Move":
		animation_tree.set("parameters/Move/blend_position", direction)
	if anime_state_machine.get_current_node() == "Dash":
		character.velocity.x *= dash_scale

func state_input(event: InputEvent):
	if event.is_action_pressed("dash") and direction != 0:
		dash()
	if event.is_action_pressed("jump"):
		jump()
	if event.is_action_pressed("attack"):
		attack()

func dash():
	anime_state_machine.travel("Dash")

func jump():
	character.velocity.y = jump_velocity
	next_state = air_state
	anime_state_machine.travel("Prepare-jump")

func attack():
	next_state = attack_state
	anime_state_machine.travel("Attack-1")

func _on_animation_tree_animation_finished(_anim_name):
	if anime_state_machine.get_current_node() == "Dash":
		anime_state_machine.travel("Move")
