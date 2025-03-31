extends State

@export var state_idle : State
@export var state_walk : State
@export var state_sprint : State
@export var state_jump : State

var does_strong_decceleration : bool = false

func on_enter() -> void:
	player.animation_tree.travel("Slide")
	player.characterbody2d.velocity.x = player.SLIDE_STRENGTH * player.last_target_direction

func on_fixed_update(delta: float) -> void:
	super(delta)
	
	var direction : int = Input.get_axis("move_left", "move_right")
	
	if player.characterbody2d.velocity.x != 0:
		player.characterbody2d.velocity.x = \
			move_toward(player.characterbody2d.velocity.x, 0,
			player.SLIDE_DECCELERATION if not does_strong_decceleration else player.SLIDE_DECCELERATION_STRONG)
	
	player.characterbody2d.move_and_slide()
	
	if Input.is_action_pressed("move_left") and player.last_target_direction == 1:
		does_strong_decceleration = true
	elif Input.is_action_pressed("move_right") and player.last_target_direction == -1:
		does_strong_decceleration = true
	
	if player.characterbody2d.velocity.x == 0 and player.characterbody2d.is_on_floor():
		if direction:
			if player.is_running:
				state_machine.enter_state(state_sprint)
			else:
				state_machine.enter_state(state_walk)
		else:
			state_machine.enter_state(state_idle)
	
	if Input.is_action_pressed("jump"):
		state_machine.enter_state(state_jump)
