class_name Main_Game
extends Node2D

@export var input_handler: Input_Handler
@export var spells_max_count : int = 10
@export var ui : Ui_Game
@export var spell_resources : Array[Resource] = []
@export var final_scene : PackedScene
@export var basic_spells_list: Array[BasicSpell] = []

var known_basic_spells: Array[BasicSpell] = []
var known_spells: Array[StringName] = []
var success : int = 0
var fails : int = 0
var current_spell : SpellResource
var current_combitnation: Array

signal success_combination
signal wrong_combination

func _ready():
	input_handler.connect("confirm", Callable(self, "_on_confirm"))
	
	reset_game()

func reset_game():
	success = 0
	fails = 0
	get_new_recipe()

func _on_confirm(combination: Array[StringName]):
	var created_basic_spell = false
	
	for basic_spell in basic_spells_list:
		if basic_spell.compare_combination(combination):
			if not current_spell.combination.has(basic_spell):
				print("¡Has creado un BasicSpell válido, pero no es parte de esta receta!")
				continue
			
			if not known_basic_spells.has(basic_spell):
				known_basic_spells.append(basic_spell)
			
			created_basic_spell = true
			ui.handle_success(current_spell.color)
			success += 1
			break 

	if not created_basic_spell:
		print("No has creado ningún BasicSpell válido para esta receta.")
		ui.handle_fail()
		fails += 1
		wrong_combination.emit()
	
	# Pide la siguiente receta
	get_new_recipe()

func get_new_recipe():
	if spell_resources.is_empty():
		push_error("There any spell resource at this obj.")
		return
	
	if success + fails >= spells_max_count:
		print("Final Game sucess: ", success ," fails: ", fails)
		GameData.player_won = success > fails
		get_tree().change_scene_to_packed(final_scene)
		return
	
	var random_index = randi() % spell_resources.size()
	current_spell = spell_resources[random_index] as SpellResource
	if(fails + success == 0):
		ui.first_rune_view(current_spell.type_view)
	else:
		ui.activate_rune_view(current_spell.type_view)
	print("New spell: ", current_spell.name, " -> ", current_spell.combination)

func _on_ui_game_time_end() -> void:
	print("Time ended!")
	wrong_combination.emit()
	fails += 1
	
	get_new_recipe()
	pass

func _on_mix(combination: Array):
	for name in combination:
		if not known_spells.has(name):
			print("No tienes el hechizo:", name)
			ui.handle_fail()
			return
	
	if current_spell and current_spell.compare_combination(combination):
		print("Success mixing:", current_spell.name)
		success += 1
		ui.handle_success(current_spell.color)
		success_combination.emit()
		known_spells.append(current_spell.name)
	else:
		print("Wrong mix.")
		wrong_combination.emit()
		ui.handle_fail()
		fails += 1
	
	get_new_recipe()
