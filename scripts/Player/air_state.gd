extends State

@export var ground_state: State
@export var air_attack_state: State
@export var dash_scale: float = 2.0
@export var air_scale: float = 0.2
@export var double_jump_velocity: float = -420.0

var can_double_jump: bool = true
var is_air_attack: bool = false
var direction: float = 0.0;

func on_state_enter():
	if not is_air_attack:
		can_double_jump = true
	is_air_attack = false

func state_process(_delta):
	direction = Input.get_axis("move_left", "move_right")
	character.velocity.x = character.speed * direction
	# Air dash
	if anime_state_machine.get_current_node() == "AirDash":
		character.velocity.x *= dash_scale
		character.velocity.y *= air_scale
	if(character.is_on_floor()):
		anime_state_machine.travel("Land")

func state_input(event: InputEvent):
	if event.is_action_pressed("dash") and direction != 0:
		dash()
	if event.is_action_pressed("jump"):
		double_jump()
	if event.is_action_pressed("attack"):
		air_attack()

func dash():
	anime_state_machine.travel("AirDash")

func air_attack():
	next_state = air_attack_state
	anime_state_machine.travel("Air-attack-1")

func double_jump():
	if can_double_jump:
		character.velocity.y = double_jump_velocity
		can_double_jump = false
		anime_state_machine.travel("Prepare-jump")

func _on_animation_tree_animation_finished(anim_name):
	if anim_name == "land":
		next_state = ground_state
	if anime_state_machine.get_current_node() == "AirDash":
		#character.velocity.y = 0.0
		anime_state_machine.travel("Fall")
