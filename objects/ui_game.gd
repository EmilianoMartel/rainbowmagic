class_name Ui_Game
extends Control

@export var input : Input_Handler
@export var game_manager : Main_Game

func _ready():
	input.first_action.connect(handle_first_rune)
	input.second_action.connect(handle_second_rune)
	input.third_action.connect(handle_thirt_rune)
	
	game_manager.success_combination.connect(handle_success)
	game_manager.wrong_combination.connect(handle_fail)
	pass

func handle_first_rune():
	pass

func handle_second_rune():
	pass

func handle_thirt_rune():
	pass

func handle_success():
	pass

func handle_fail():
	pass

func activate_rune_view():
	pass
