extends Node2D

@export var Success :  Texture
@export var Fail : Texture
@export var WinOrLose : Sprite2D

func _ready():
	check_win_or_lose()
	pass

func _on_back_button_up() -> void:
	var scene = load("res://scenes/main_menu.tscn") as PackedScene
	if scene:
		get_tree().change_scene_to_packed(scene)
	else:
		print("Cant charge scene.")

func check_win_or_lose():
	if(GameData.player_won):
		WinOrLose.texture = Success
	else:
		WinOrLose.texture = Fail
