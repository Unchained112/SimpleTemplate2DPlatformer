extends Node2D

@export var label: Label # load the label to the instance
@onready var anim_player = $AnimationPlayer

func _ready():
	anim_player.play("show")

func set_num(num: int):
	label.text = str(num)

func _on_animation_player_animation_finished(_anim_name):
	queue_free()
