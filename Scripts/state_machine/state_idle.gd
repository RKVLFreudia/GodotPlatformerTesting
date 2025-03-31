extends State

@export var walk_state : State
@export var jump_state : State
@export var sprint_state : State

func on_enter():
	player.animation_tree.travel("Idle")
	player.is_running = false
	
func on_fixed_update(delta: float):
	super(delta)
	player.characterbody2d.move_and_slide()
		
	if (Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right")) \
		and !state_machine.input_controller.is_double_tap:
		state_machine.enter_state(walk_state)
	
	if (Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right")) \
		and state_machine.input_controller.is_double_tap:
		state_machine.enter_state(sprint_state)
	
	if Input.is_action_pressed("jump"):
		state_machine.enter_state(jump_state)
