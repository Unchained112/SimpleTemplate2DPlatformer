extends Control

@export var damage_number: PackedScene

func _ready():
	SignalBus.health_changed.connect(_on_health_changed)

func _on_health_changed(node: Node, amount: int):
	var damage_num = damage_number.instantiate()
	#damage_num.num.text = str(amount)
	# TODO: Fix damage number issue
	node.add_child(damage_num)
