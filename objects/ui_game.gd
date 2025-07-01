class_name Ui_Game
extends Control

@export var input : Input_Handler
@export var game_manager : Main_Game
@export var left_bar: ProgressBar
@export var right_bar: ProgressBar
@export var timer: Timer
@export var spell_to_do : Sprite2D
@export var spell : Sprite2D
@export var spells_label : Label
@export var duration: float = 60

var to_change_image : Texture
var is_timer_stopped: bool = false
signal time_end

var current_combination: String

func _process(delta):
	if timer.time_left > 0 || !is_timer_stopped:
		var total_time = timer.wait_time
		var elapsed_time = total_time - timer.time_left
		var percent = elapsed_time / total_time
		left_bar.value = percent * left_bar.max_value
		right_bar.value = percent * right_bar.max_value

func _ready():
	input.first_action.connect(handle_first_rune)
	input.second_action.connect(handle_second_rune)
	input.third_action.connect(handle_thirt_rune)
	input.confirm.connect(handle_confirm)
	input.mix.connect(handle_confirm)
	
	game_manager.success_combination.connect(handle_success)
	game_manager.wrong_combination.connect(handle_fail)
	reset_time()
	pass

func handle_first_rune():
	if current_combination.length() >= 3:
		current_combination = current_combination.substr(1)
	
	current_combination += "Q"
	spells_label.text = current_combination

func handle_second_rune():
	if current_combination.length() >= 3:
		current_combination = current_combination.substr(1)
	
	current_combination += "W"
	spells_label.text = current_combination

func handle_thirt_rune():
	if current_combination.length() >= 3:
		current_combination = current_combination.substr(1)
	
	current_combination += "E"
	spells_label.text = current_combination

func handle_success(color: Color) -> void:
	timer.stop()
	is_timer_stopped = true
	var temp_color :Color = spell.modulate
	var tween := create_tween()
	tween.tween_property(spell, "modulate", color, 0.3)
	await tween.finished
	await get_tree().create_timer(1.4).timeout
	tween = create_tween()
	tween.tween_property(spell, "modulate", temp_color, 0.3)
	await tween.finished
	
	spell_to_do.texture = to_change_image
	reset_time()

func handle_fail():
	timer.stop()
	spell_to_do.texture = to_change_image
	
	reset_time()
	pass

func first_rune_view(sprite:Texture):
	spell_to_do.texture = sprite

func activate_rune_view(sprite:Texture):
	to_change_image = sprite
	pass

func reset_time():
	is_timer_stopped = false
	timer.stop()
	timer.wait_time = duration
	timer.one_shot = true
	timer.start()
	left_bar.value = 0
	right_bar.value = 0

func _on_timer_timeout() -> void:
	time_end.emit()

func handle_confirm(combination: Array[StringName]):
	current_combination = ""
	spells_label.text = current_combination
	pass
