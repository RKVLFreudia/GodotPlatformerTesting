class_name StateMachine extends Node

@export var sm_owner : Player
@export var default_state : State
var current_state : State
var states : Dictionary[String, State]

func _ready() -> void:
	await sm_owner.ready # Waits for the parent's script to be ready
	# Inject self into all child states, then add them to the dictionary
	for child in get_children():
		if child is State:
			child.state_machine = self
			states[child.state_name.to_lower()] = child
	
	enter_state(default_state)
	current_state = default_state
	
# Maybe use this to get the references instead of hard coding the references?...
func get_state(state: String) -> State:
	if states.has(state.to_lower()):
		return states[state.to_lower()]
	
	printerr("The state: '" + state + "' does not exist.")
	return default_state

func enter_state(new_state: State) -> void:
	if current_state:
		current_state.on_exit()
		
	new_state.on_enter()
	current_state = new_state
	
func _process(delta: float) -> void:
	sm_owner.state_label.text = "State: " + current_state.state_name
	
	if current_state != null:
		current_state.on_update(delta)
		
func _physics_process(delta: float) -> void:
	last_key_delta += delta
	
	if current_state != null:
		current_state.on_fixed_update(delta)
		
#=========================================================================
const COMBO_TIMEOUT = 0.2
const MAX_COMBO_CHAIN = 2

var last_key_delta = 0
var key_combo = []
		
func _input(event):
	if event is InputEventKey and event.pressed and !event.echo:
		if last_key_delta > COMBO_TIMEOUT:
			key_combo = []
		
		key_combo.append(event)
		if key_combo.size() > MAX_COMBO_CHAIN:
			key_combo.pop_front()

		last_key_delta = 0
