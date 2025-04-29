extends Node

signal first_power
signal second_power
signal third_power
signal confirm

func _physics_process(delta: float) -> void:
	if (Input.is_action_pressed("FirstPower")) :
		first_power.emit()
	if (Input.is_action_pressed("SecondPower")) :
		second_power.emit()
	if (Input.is_action_pressed("ThirdPower")) :
		third_power.emit()
	if (Input.is_action_pressed("Confirm")) :
		confirm.emit()
