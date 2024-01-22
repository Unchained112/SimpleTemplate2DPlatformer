extends CharacterBody2D

@export var is_idle: bool = true
@export var is_knockback: bool = false

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var health: int = 100:
	get:
		return health
	set(value):
		SignalBus.health_changed.emit(self, value - health)
var target: CharacterBody2D

@onready var sprite: Sprite2D = $Sprite2D
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var bleeding_particle: GPUParticles2D = $BleedingParticle

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	move_and_slide()

func register_target(player: CharacterBody2D):
	target = player

func get_damage(damage: int):
	print("Got attacked, damage: " + str(damage))
	health -= damage
	bleeding_particle.emitting = true
