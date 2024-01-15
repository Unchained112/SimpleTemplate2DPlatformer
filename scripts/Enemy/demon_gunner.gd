extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var health: int = 100:
	get:
		return health
	set(value):
		SignalBus.health_changed.emit(self, value - health)
		health = value

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	move_and_slide()

func get_damage(damage: int):
	print("Got attacked, damage: " + str(damage))
	health -= damage
