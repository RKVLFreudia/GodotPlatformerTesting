extends State

@export var idle_state : State
@export var walk_state : State
@export var sprint_state : State

func on_enter():
	player.animation_controller.request_travel(player.animation_controller.AnimationType.FALL)
	
func on_fixed_update(delta: float) -> void:
	if not player.characterbody2d.is_on_floor(): 
		player.characterbody2d.velocity += (player.characterbody2d.get_gravity() * 1.5) * delta
	
	var direction : int = Input.get_axis("move_left", "move_right")
	player.last_target_direction = direction
	
	if direction < 0: player.set_flip_h(true)
	elif direction > 0: player.set_flip_h(false)
	
	if direction:
		player.characterbody2d.velocity.x = player.last_target_speed * direction
	else:
		player.characterbody2d.velocity.x = move_toward(player.characterbody2d.velocity.x, 0,
			player.last_target_speed)
	
	player.characterbody2d.move_and_slide()
	
	if (Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right")) \
		and state_machine.input_controller.is_double_tap:
		player.is_running = true

	if player.characterbody2d.is_on_floor():
		player.animation_controller.request_travel(player.animation_controller.AnimationType.FALL_EXIT, false)
		if direction: # If theres input direction
			if player.is_running: # If previously running
				state_machine.enter_state(sprint_state)
			else:
				state_machine.enter_state(walk_state)
		else: # If there is not input direction
			state_machine.enter_state(idle_state)
			
