extends State

@export var jump_velocity: float = -400.0
@export var dash_scale: float = 2.5
@export var air_state: State

var direction: float = 0.0;

func state_process(_delta):
	if not character.is_on_floor():
		next_state = air_state
		anime_state_machine.travel("Fall")
		#animation_tree.set("parameters/conditions/is_fall", true)

	direction = Input.get_axis("move_left", "move_right")
	character.velocity.x = character.speed * direction
	if anime_state_machine.get_current_node() == "Move":
		animation_tree.set("parameters/Move/blend_position", direction)
	if anime_state_machine.get_current_node() == "Dash":
		character.velocity.x *= dash_scale

func state_input(event: InputEvent):
	if event.is_action_pressed("dash"):
		dash()
	if event.is_action_pressed("jump"):
		jump()

func dash():
	anime_state_machine.travel("Dash")

func jump():
	character.velocity.y = jump_velocity
	next_state = air_state
	anime_state_machine.travel("Prepare-jump")
	#animation_tree.set("parameters/conditions/is_jump", true)

func _on_animation_tree_animation_finished(_anim_name):
	if anime_state_machine.get_current_node() == "Dash":
		anime_state_machine.travel("Move")
