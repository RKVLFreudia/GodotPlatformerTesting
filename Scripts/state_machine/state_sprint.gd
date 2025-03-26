extends State

@export var sprite : Sprite2D
@export var state_idle : State

func on_enter():
	state_machine.sm_owner.animation_tree.travel("Sprint")
	
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
			(state_machine.sm_owner.WALK_SPEED * state_machine.sm_owner.SPRINT_SPEED_MULT) * direction
	else:
		state_machine.sm_owner.characterbody2d.velocity.x = \
			move_toward(state_machine.sm_owner.characterbody2d.velocity.x, 0,
			(state_machine.sm_owner.WALK_SPEED * state_machine.sm_owner.SPRINT_SPEED_MULT))
		
	if direction == 0 and state_machine.sm_owner.characterbody2d.is_on_floor():
		state_machine.enter_state(state_idle)
	
func set_offset() -> Vector2:
	var new_offset := Vector2(0, 0)
	
	if state_machine.sm_owner.sprite.flip_h:
		new_offset.x = -43
		
	return new_offset
