extends Node2D

@export var other_scene : PackedScene
@export var Success :  Texture
@export var Fail : Texture
@export var WinOrLose : Sprite2D

func _ready():
	pass

func _on_play_button_button_down() -> void:
	get_tree().change_scene_to_packed(other_scene)
	pass

func check_win_or_lose():
	if(GameData.player_won):
		WinOrLose.image = Success
	else:
		WinOrLose.image = Fail
