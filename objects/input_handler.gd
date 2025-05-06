class_name Input_Handler
extends Node

var current_combination: Array[StringName] = []

signal first_action
signal second_action
signal third_action
signal confirm(combination: Array)

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("FirstPower"):
		add_new_input("FirstPower")
	if Input.is_action_just_pressed("SecondPower"):
		add_new_input("SecondPower")
	if Input.is_action_just_pressed("ThirdPower"):
		add_new_input("ThirdPower")
	if Input.is_action_just_pressed("Confirm"):
		confirm.emit(current_combination)
		current_combination.clear()

func add_new_input(add_input: String) -> void:
	if current_combination.size() >= 3:
		current_combination.remove_at(0)
	
	current_combination.append(add_input)
	print("Actual combination:", current_combination)
	pass
