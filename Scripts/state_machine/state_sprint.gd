extends State

const WALK_SPEED : float = 300.0
const SPEED_MULT : float = 1.6
const FLIP_OFFSET_ON := Vector2(-43, 0)
const JUMP_OFFSET := Vector2(0, 20)

@export var sprite : Sprite2D
@export var state_idle : State

func on_enter():
	animation_tree.travel("Walk")
	
func on_exit():
	pass
	
func on_fixed_update(delta: float) -> void:
	super(delta)
	state_owner.move_and_slide()
	
	var direction : int = Input.get_axis("move_left", "move_right")
	
	if direction < 0:
		sprite.flip_h = true
	elif direction > 0:
		sprite.flip_h = false
	
	sprite.offset = set_offset()
	
	if direction:
		state_owner.velocity.x = (WALK_SPEED * SPEED_MULT) * direction
	else:
		state_owner.velocity.x = move_toward(state_owner.velocity.x, 0, (WALK_SPEED * SPEED_MULT))
		
	if direction == 0 and state_owner.is_on_floor():
		state_machine.enter_state(state_idle)
	
func set_offset() -> Vector2:
	var new_offset := Vector2(0, 0)
	
	if sprite.flip_h:
		new_offset.x = -43
	
	if not state_owner.is_on_floor():
		new_offset.y = 20
		
	return new_offset
