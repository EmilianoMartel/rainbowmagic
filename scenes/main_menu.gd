extends Control

@export var other_scene : PackedScene
@export var credits : Node

func _on_play_button_button_down() -> void:
	get_tree().change_scene_to_packed(other_scene)
	pass


func _on_credit_button_button_down() -> void:
	credits.visible = true


func _on_back_to_menu_c_button_down() -> void:
	credits.visible = false
