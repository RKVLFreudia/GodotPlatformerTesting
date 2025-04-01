class_name InputController extends Node

const DOUBLE_TAP_WINDOW : float = 0.25
const INPUT_BUFFER_WINDOW : float = 0.1
const COYOTE_TIME : float = 0.1

var _current_elapsed_time : float = DOUBLE_TAP_WINDOW

var buffered_input : int = 0 # InputEvent.keycode
var last_input : int = 0 # InputEvent.keycode

var buffered_input_event : InputEvent
var last_input_event : InputEvent

var is_double_tap : bool = false

func _process(delta: float) -> void:
	_current_elapsed_time -= delta # Tick time
	clampf(_current_elapsed_time, -1, 10) # Just so it doesn't goes to crazy numbers

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed() and !event.is_echo():
		last_input_event = event
		
		if event.keycode == last_input and _current_elapsed_time >= 0:
			is_double_tap = true
		else:
			last_input_event = event
			last_input = event.keycode # Keep elgacy working
			is_double_tap = false
			
		_current_elapsed_time = DOUBLE_TAP_WINDOW

func is_pressed(action: String) -> bool:
	if InputMap.event_is_action(last_input_event, action):
		return true
	return false
