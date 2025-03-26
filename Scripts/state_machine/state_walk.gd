extends State

@export var idle_state : State
@export var jump_state : State
@export var sprint_state : State

func on_enter() -> void:
	state_machine.sm_owner.animation_tree.travel("Walk")

func on_exit() -> void:
	pass

func on_fixed_update(delta: float) -> void:
	super(delta)
	state_machine.sm_owner.characterbody2d.move_and_slide()
	
	var direction : int = Input.get_axis("move_left", "move_right")
	
	if direction < 0:
		state_machine.sm_owner.sprite.flip_h = true
	elif direction > 0:
		state_machine.sm_owner.sprite.flip_h = false
	
	state_machine.sm_owner.sprite.offset = set_offset()
	
	if direction:
		state_machine.sm_owner.characterbody2d.velocity.x = \
			state_machine.sm_owner.WALK_SPEED * direction
	else:
		state_machine.sm_owner.characterbody2d.velocity.x = \
			move_toward(state_machine.sm_owner.characterbody2d.velocity.x, 0,
				state_machine.sm_owner.WALK_SPEED)
		
	if direction == 0 and state_machine.sm_owner.characterbody2d.is_on_floor():
		state_machine.enter_state(idle_state)
	
	# ======================================
	var combo = 0
	for input in state_machine.key_combo:
		if InputMap.action_has_event("move_left", input):
			combo += 1
	if combo == 2:
		state_machine.enter_state(sprint_state)
	
	combo = 0
	for input in state_machine.key_combo:
		if InputMap.action_has_event("move_right", input):
			combo += 1
	if combo == 2:
		state_machine.enter_state(sprint_state)
	
	# ======================================
		
	if Input.is_action_pressed("jump"):
		state_machine.enter_state(jump_state)
		
func set_offset() -> Vector2:
	var new_offset := Vector2(0, 0)
	
	if state_machine.sm_owner.sprite.flip_h:
		new_offset.x = -43

	return new_offset
	
