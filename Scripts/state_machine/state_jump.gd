extends State

const JUMP_VELOCITY : float = -400.0
const WALK_SPEED : float = 300.0
const FLIP_OFFSET_ON := Vector2(-43, 0)
const JUMP_OFFSET := Vector2(0, 20)

@export var idle_state : State
@export var walk_state : State
@export var sprite : Sprite2D

func on_enter() -> void:
	animation_tree.travel("Jump")
	state_owner.velocity.y = JUMP_VELOCITY
	
func on_fixed_update(delta: float) -> void:
	super(delta)
	
	var direction : int = Input.get_axis("move_left", "move_right")
	
	if direction < 0:
		sprite.flip_h = true
	elif direction > 0:
		sprite.flip_h = false
	
	sprite.offset = set_offset()
	
	if direction:
		state_owner.velocity.x = WALK_SPEED * direction
	else:
		state_owner.velocity.x = move_toward(state_owner.velocity.x, 0, WALK_SPEED)
		
	state_owner.move_and_slide()
	
	if state_owner.is_on_floor():
		if direction == 0:
			state_machine.enter_state(idle_state)
		else:
			state_machine.enter_state(walk_state)
			
func set_offset() -> Vector2:
	var new_offset := Vector2(0, 0)
	
	if sprite.flip_h:
		new_offset.x = -43
	
	if not state_owner.is_on_floor():
		new_offset.y = 20
		
	return new_offset
