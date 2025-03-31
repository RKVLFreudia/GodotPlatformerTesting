extends State

@export var idle_state : State
@export var walk_state : State
@export var sprint_state : State
@export var falling_state : State

signal on_jump

func on_enter() -> void:
	player.animation_tree.travel("Jump_entry")
	
func on_fixed_update(delta: float) -> void:
	super(delta)
	
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
	
	if player.characterbody2d.velocity.y > 0:
		state_machine.enter_state(falling_state)
		
func _on_jump() -> void:
	player.characterbody2d.velocity.y = player.JUMP_VELOCITY
