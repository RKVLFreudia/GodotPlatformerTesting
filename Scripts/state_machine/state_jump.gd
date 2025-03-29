extends State

@export var idle_state : State
@export var walk_state : State

func on_enter() -> void:
	player.animation_tree.travel("Jump")
	player.characterbody2d.velocity.y = player.JUMP_VELOCITY
	
func on_fixed_update(delta: float) -> void:
	super(delta)
	
	var direction : int = Input.get_axis("move_left", "move_right")
	
	if direction < 0: player.set_flip_h(true)
	elif direction > 0: player.set_flip_h(false)
	
	if direction:
		player.characterbody2d.velocity.x = player.WALK_SPEED * direction
	else:
		player.characterbody2d.velocity.x = move_toward(player.characterbody2d.velocity.x, 0,
			player.WALK_SPEED)
		
	player.characterbody2d.move_and_slide()
	
	if player.characterbody2d.is_on_floor():
		if direction == 0:
			state_machine.enter_state(idle_state)
		else:
			state_machine.enter_state(walk_state)
