extends State

@export var state_idle : State
@export var jump_state : State

func on_enter():
	player.animation_tree.travel("Sprint")
	
func on_exit():
	player.last_target_speed = player.WALK_SPEED * player.SPRINT_SPEED_MULT
	
func on_fixed_update(delta: float) -> void:
	super(delta)
	player.characterbody2d.move_and_slide()
	
	var direction : int = Input.get_axis("move_left", "move_right")
	
	if direction < 0: player.set_flip_h(true)
	elif direction > 0: player.set_flip_h(false)
	
	if direction:
		player.characterbody2d.velocity.x = move_toward(player.characterbody2d.velocity.x, 
			(player.WALK_SPEED * player.SPRINT_SPEED_MULT) * direction,
			player.SPRINT_ACCELERATION)
	else:
		player.characterbody2d.velocity.x = move_toward(player.characterbody2d.velocity.x, 0,
			player.SPRINT_DECCELERATION)
		
	if player.characterbody2d.velocity.x == 0 and player.characterbody2d.is_on_floor():
		state_machine.enter_state(state_idle)
		
	if Input.is_action_pressed("jump"):
		state_machine.enter_state(jump_state)
