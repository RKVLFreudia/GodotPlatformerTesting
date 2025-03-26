extends State

@export var idle_state : State
@export var walk_state : State

func on_enter() -> void:
	state_machine.sm_owner.animation_tree.travel("Jump")
	state_machine.sm_owner.characterbody2d.velocity.y = \
		state_machine.sm_owner.JUMP_VELOCITY
	
func on_fixed_update(delta: float) -> void:
	super(delta)
	
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
		
	state_machine.sm_owner.characterbody2d.move_and_slide()
	
	if state_machine.sm_owner.characterbody2d.is_on_floor():
		if direction == 0:
			state_machine.enter_state(idle_state)
		else:
			state_machine.enter_state(walk_state)
			
func set_offset() -> Vector2:
	var new_offset := Vector2(0, 0)
	
	if state_machine.sm_owner.sprite.flip_h:
		new_offset.x = -43

	return new_offset
