extends Node2D

@export var final_scene : PackedScene
@export var Success :  Texture
@export var Fail : Texture
@export var WinOrLose : Sprite2D

func _ready():
	check_win_or_lose()
	pass

func _on_back_button_up() -> void:
	get_tree().change_scene_to_packed(final_scene)
	pass

func check_win_or_lose():
	if(GameData.player_won):
		WinOrLose.image = Success
	else:
		WinOrLose.image = Fail
