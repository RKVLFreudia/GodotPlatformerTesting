extends State

@export var idle_state : State
@export var jump_state : State
@export var state_falling : State


func on_enter() -> void:
	player.animation_controller.request_travel(player.animation_controller.AnimationType.WALK)
	
func on_exit() -> void:
	player.last_target_speed = player.WALK_SPEED

func on_fixed_update(delta: float) -> void:
	if not player.characterbody2d.is_on_floor(): 
		player.characterbody2d.velocity += player.characterbody2d.get_gravity() * delta
		state_machine.enter_state(state_falling)

	player.characterbody2d.move_and_slide()
	
	var direction : int = Input.get_axis("move_left", "move_right")
	player.last_target_direction = direction
	
	if direction < 0: player.set_flip_h(true)
	elif direction > 0: player.set_flip_h(false)
	
	if direction:
		player.characterbody2d.velocity.x = move_toward(player.characterbody2d.velocity.x, 
				player.WALK_SPEED * direction, player.WALK_ACCELERATION)
	elif direction == 0:
		player.characterbody2d.velocity.x = move_toward(player.characterbody2d.velocity.x,
			0.0, player.WALK_DECCELERATION)
		
	if player.characterbody2d.velocity.x == 0 and player.characterbody2d.is_on_floor():
		state_machine.enter_state(idle_state)
		
	if Input.is_action_pressed("jump"):
		state_machine.enter_state(jump_state)
