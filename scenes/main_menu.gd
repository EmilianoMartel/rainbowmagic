extends Control

@export var other_scene : PackedScene

func _on_play_button_button_down() -> void:
	get_tree().change_scene_to_packed(other_scene)
	pass
