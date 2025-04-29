extends Node2D

@export var spells_max_count : int = 10

var success : int = 0
var fails : int = 0

func reset_game():
	success = 0
	fails = 0
	pass
