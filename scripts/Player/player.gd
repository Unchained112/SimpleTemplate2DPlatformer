extends CharacterBody2D

@export var speed = 360.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var damage: int = 20
var health: int = 100

@onready var sprite: Sprite2D = $Sprite2D
@onready var animation_tree: AnimationTree = $AnimationTree

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	# Handle sprite direction
	var direction = Input.get_axis("move_left", "move_right")
	if direction > 0:
		sprite.flip_h = false
	elif direction < 0:
		sprite.flip_h = true

	move_and_slide()

func _on_attack_area_2d_body_entered(body):
	print("Attacking")
