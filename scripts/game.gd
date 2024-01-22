extends Node2D

@export var freeze_slow: float = 0.6
@export var freeze_time: float = 0.2

func _ready():
	SignalBus.health_changed.connect(_on_damage_taken)

func freeze_engine():
	Engine.time_scale = freeze_slow
	await get_tree().create_timer(freeze_time).timeout
	Engine.time_scale = 1.0

func _on_damage_taken(_node: Node, amount: int):
	# only when taking damage
	if (amount < 0):
		freeze_engine()
