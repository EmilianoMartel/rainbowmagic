class_name Main_Game
extends Node2D

@export var input_handler: Input_Handler
@export var spells_max_count : int = 10
@export var spell_resources : Array[Resource] = []

var success : int = 0
var fails : int = 0
var current_spell : SpellResource

signal success_combination
signal wrong_combination
signal final

func _ready():
	input_handler.connect("confirm", Callable(self, "_on_confirm"))
	
	reset_game()

func reset_game():
	success = 0
	fails = 0
	get_new_recipe()

func _on_confirm(combination: Array):
	if current_spell and current_spell.compare_combination(combination):
		print("Succes:", current_spell.name)
		success_combination.emit()
		success += 1
	else:
		print("Wrong combination.")
		wrong_combination.emit()
		fails += 1
	
	get_new_recipe()

func get_new_recipe():
	if spell_resources.is_empty():
		push_error("There any spell resource at this obj.")
		return
	
	if success + fails >= spells_max_count:
		print("Final Game sucess: ", success ," fails: ", fails)
		final.emit()
	
	var random_index = randi() % spell_resources.size()
	current_spell = spell_resources[random_index] as SpellResource
	print("New spell: ", current_spell.name, " -> ", current_spell.combination)
