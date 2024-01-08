extends State

@export var ground_state: State
@export var dash_scale: float = 2.0
@export var air_scale: float = 0.8
@export var double_jump_velocity: float = -300.0

var can_double_jump: bool = true
var direction: float = 0.0;

func on_state_enter():
	can_double_jump = true
	#animation_tree.set("parameters/conditions/is_jump", false)
	#animation_tree.set("parameters/conditions/is_fall", false)

func state_process(_delta):
	direction = Input.get_axis("move_left", "move_right")
	character.velocity.x = character.speed * direction * air_scale
	# Air dash
	if anime_state_machine.get_current_node() == "AirDash":
		character.velocity.x *= dash_scale
		character.velocity.y = 0.0

	if(character.is_on_floor()):
		anime_state_machine.travel("Land")

func state_input(event: InputEvent):
	if event.is_action_pressed("dash"):
		dash()
	if event.is_action_pressed("jump"):
		double_jump()

func dash():
	anime_state_machine.travel("AirDash")

func double_jump():
	if can_double_jump:
		character.velocity.y = double_jump_velocity
		can_double_jump = false
		anime_state_machine.travel("Prepare-jump")

func _on_animation_tree_animation_finished(anim_name):
	if anim_name == "land":
		next_state = ground_state
	if anime_state_machine.get_current_node() == "AirDash":
		anime_state_machine.travel("Fall")
