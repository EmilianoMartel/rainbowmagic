extends Node

var recipes = []

func _ready():
	load_recipes()

func load_recipes():
	var file = FileAccess.open("res://resorces/recipes.json", FileAccess.READ)
	if file:
		var content = file.get_as_text()
		recipes = JSON.parse_string(content)
	else:
		push_error("File can´t be open")

func find_recipe(input_combination: Array[String]) -> String:
	for recipe in recipes:
		if recipe["combination"] == input_combination:
			return recipe["result"]
	return "Recipe don´t found"
