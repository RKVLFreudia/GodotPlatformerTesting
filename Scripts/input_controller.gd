class_name InputController extends Node

const MAX_DOUBLE_TAP_WINDOW = 0.25
var current_elapsed_time = MAX_DOUBLE_TAP_WINDOW

var last_key_pressed : int
var is_double_tap : bool = false

func _process(delta: float) -> void:
	current_elapsed_time -= delta # Tick time
	clampf(current_elapsed_time, -1, 10) # Just so it doesn't goes to crazy numbers

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed() and !event.is_echo():
		if event.keycode == last_key_pressed and current_elapsed_time >= 0:
			is_double_tap = true
		else:
			last_key_pressed = event.keycode
			is_double_tap = false
			
		current_elapsed_time = MAX_DOUBLE_TAP_WINDOW
