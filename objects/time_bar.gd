extends Control

@onready var left = TextureRect
@onready var right = TextureRect

@export var max_value: float = 100
var current_value: float = 100

func _process(delta):
	var percent = clamp(current_value / max_value, 0.0, 1.0)

	var full_width = 200
	var half_width = full_width * 0.5 * percent

	left.size.x = half_width
	right.size.x = half_width

	left.position.x = full_width * 0.5 - half_width
	right.position.x = full_width * 0.5
