extends CharacterBody2D

@export var speed = 360.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var damage: int = 20
var health: int = 100
var heavy_attack_damage: int = 30
var is_dashing: bool = false

@onready var sprite: Sprite2D = $Sprite2D
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var attack_area: Area2D = $AttackArea2D
@onready var heavy_attack_area: Area2D = $HeavyAttackArea2D
@onready var air_attack_area: Area2D = $AirAttackArea2D
@onready var move_trail: GPUParticles2D = $PlayerMoveTrail
@onready var dash_trail: GPUParticles2D = $PlayerDashTrail

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	# Handle sprite direction
	var direction = Input.get_axis("move_left", "move_right")
	update_player_dir(direction)
	update_trail()
	move_and_slide()

func update_player_dir(direction: float):
	if direction > 0:
		sprite.flip_h = false
		attack_area.scale.x = 1
		heavy_attack_area.scale.x = 1
		air_attack_area.scale.x = 1
	elif direction < 0:
		sprite.flip_h = true
		attack_area.scale.x = -1
		heavy_attack_area.scale.x = -1
		air_attack_area.scale.x = -1

func update_trail():
	if velocity.length_squared() > 0:
		if is_dashing:
			dash_trail.emitting = true
		else:
			move_trail.emitting = true

func _on_attack_area_2d_body_entered(body):
	print(body.name)
	body.get_damage(damage)

func _on_heavy_attack_area_2d_body_entered(body):
	print(body.name)
	body.get_damage(heavy_attack_damage)

func _on_air_attack_area_2d_body_entered(body):
	print(body.name)
	body.get_damage(damage)
