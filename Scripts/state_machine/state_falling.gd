extends State

@export var idle_state : State
@export var walk_state : State
@export var sprint_state : State

func on_enter():
	player.animation_tree.travel("jump_falling")
	
func on_fixed_update(delta: float) -> void:
	super(delta)
	
	var direction : int = Input.get_axis("move_left", "move_right")
	
	if direction < 0: player.set_flip_h(true)
	elif direction > 0: player.set_flip_h(false)
	
	if direction:
		player.characterbody2d.velocity.x = player.last_target_speed * direction
	else:
		player.characterbody2d.velocity.x = move_toward(player.characterbody2d.velocity.x, 0,
			player.last_target_speed)
	
	player.characterbody2d.move_and_slide()

	if player.characterbody2d.is_on_floor():
		player.animation_tree.travel("jump_exit")
		
func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == "jump_exit":
		state_machine.enter_state(idle_state)
