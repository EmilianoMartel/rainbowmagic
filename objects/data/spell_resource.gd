class_name SpellResource
extends Resource

@export var name : String = "Spell"
@export var combination: Array[StringName] = ["FirstPower", "FirstPower", "FirstPower"]
@export var color : Color

func compare_combination(input_combination: Array[StringName]) -> bool:
	if combination.size() != input_combination.size():
		return false
	
	for i in range(combination.size()):
		if combination[i] != input_combination[i]:
			return false
	
	return true
