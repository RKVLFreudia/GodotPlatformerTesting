extends State

const WALK_SPEED : float = 300.0
const FLIP_OFFSET_ON := Vector2(-43, 0)
const JUMP_OFFSET := Vector2(0, 20)

@export var idle_state : State
@export var jump_state : State
@export var sprint_state : State
@export var sprite : Sprite2D

func on_enter() -> void:
	animation_tree.travel("Walk")

func on_exit() -> void:
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
		state_owner.velocity.x = WALK_SPEED * direction
	else:
		state_owner.velocity.x = move_toward(state_owner.velocity.x, 0, WALK_SPEED)
		
	if direction == 0 and state_owner.is_on_floor():
		state_machine.enter_state(idle_state)
	
	# ======================================
	var combo = 0
	for input in state_machine.key_combo:
		if InputMap.action_has_event("move_left", input):
			combo += 1
	if combo == 2:
		state_machine.enter_state(sprint_state)
	
	combo = 0
	for input in state_machine.key_combo:
		if InputMap.action_has_event("move_right", input):
			combo += 1
	if combo == 2:
		state_machine.enter_state(sprint_state)
	
	# ======================================
		
	if Input.is_action_pressed("jump"):
		state_machine.enter_state(jump_state)
		
func set_offset() -> Vector2:
	var new_offset := Vector2(0, 0)
	
	if sprite.flip_h:
		new_offset.x = -43
	
	#if not state_owner.is_on_floor():
		#new_offset.y = 20
		
	return new_offset
	
