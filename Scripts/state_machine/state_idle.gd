extends State

@export var walk_state : State
@export var jump_state : State

func on_enter():
	animation_tree.travel("Idle")
	
func on_fixed_update(delta: float):
	super(delta)
	state_owner.move_and_slide()
	
	if not Input.get_axis("move_left", "move_right") == 0:
		state_machine.enter_state(walk_state)
	
	if Input.is_action_pressed("jump"):
		state_machine.enter_state(jump_state)
