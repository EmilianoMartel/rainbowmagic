class_name BasicSpell
extends Resource

@export var combination: Array[StringName] = ["FirstPower", "FirstPower", "FirstPower"]

func compare_combination(input_combination: Array[StringName]) -> bool:
	if combination.size() != input_combination.size():
		return false
	
	var combination_copy = combination.duplicate()
	
	for input in input_combination:
		if combination_copy.has(input):
			combination_copy.erase(input)
		else:
			return false
	
	return combination_copy.is_empty()
