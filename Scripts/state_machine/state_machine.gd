class_name StateMachine extends Node

@export var player : CharacterBody2D
@onready var label: Label = $"../Label"
@onready var animation_state_machine : AnimationNodeStateMachinePlayback = \
		$"../AnimationTree"["parameters/playback"]

@export var default_state : State
var current_state : State

const COMBO_TIMEOUT = 0.15
const MAX_COMBO_CHAIN = 2

var last_key_delta = 0
var key_combo = []

func _ready() -> void:
	for child in get_children():
		if child is State:
			child.state_owner = player
			child.animation_tree = animation_state_machine
			child.state_machine = self
	
	enter_state(default_state)
	current_state = default_state
	
func enter_state(new_state: State) -> void:
	if current_state:
		current_state.on_exit()
		
	new_state.on_enter()
	current_state = new_state
	
func _process(delta: float) -> void:
	label.text = "State: " + current_state.to_string()
	
	if current_state != null:
		current_state.on_update(delta)
		
func _physics_process(delta: float) -> void:
	last_key_delta += delta
	
	if current_state != null:
		current_state.on_fixed_update(delta)
		
		
func _input(event):
	if event is InputEventKey and event.pressed and !event.echo:
		if last_key_delta > COMBO_TIMEOUT:
			key_combo = []
		
		key_combo.append(event)
		if key_combo.size() > MAX_COMBO_CHAIN:
			key_combo.pop_front()

		last_key_delta = 0
