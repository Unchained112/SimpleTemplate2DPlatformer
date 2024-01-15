extends Node2D

@onready var anim_player = $AnimationPlayer
@onready var num = $Label

func _ready():
	anim_player.play("show")

func _on_animation_player_animation_finished(_anim_name):
	queue_free()
