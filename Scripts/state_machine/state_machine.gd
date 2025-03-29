class_name StateMachine extends Node

@export var sm_owner : Player
@export var default_state : State
@export var input_controller : InputController
var current_state : State
#var states : Dictionary[String, State]



func _ready() -> void:
	await sm_owner.ready # Waits for the parent's script to be ready
	# Inject self into all child states, then add them to the dictionary
	for child in get_children():
		if child is State:
			child.state_machine = self
			child.player = sm_owner
			#states[child.state_name.to_lower()] = child
	
	enter_state(default_state)
	current_state = default_state
	
# Maybe use this to get the references instead of hard coding the references?...
#func get_state(state: String) -> State:
	#if states.has(state.to_lower()):
		#return states[state.to_lower()]
	#
	#printerr("The state: '" + state + "' does not exist.")
	#return default_state

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
	
	if current_state != null:
		current_state.on_fixed_update(delta)
		
func _input(event: InputEvent) -> void:
	if current_state:
		current_state.on_input_handle(event)
