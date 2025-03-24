extends CharacterBody2D

const SPEED : float = 300.0
const JUMP_VELOCITY : float = -400.0
const FLIP_OFFSET_ON := Vector2(-43, 0)
const JUMP_OFFSET := Vector2(0, 20)

@onready var sprite: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animation_tree: AnimationTree = $AnimationTree

@onready var state_machine : AnimationNodeStateMachinePlayback = animation_tree["parameters/playback"]

func _ready() -> void:
	state_machine = animation_tree["parameters/playback"]
	pass

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		state_machine.travel("Jump")
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		state_machine.travel("Jump")
		velocity.y = JUMP_VELOCITY

	# -1 = left, 0 = idle, 1 = right
	var direction := Input.get_axis("move_left", "move_right")
	
	if direction < 0:
		sprite.flip_h = true
	elif direction > 0:
		sprite.flip_h = false
		
	if direction == 0  and is_on_floor():
		state_machine.travel("Idle")
	elif direction != 0  and is_on_floor():
		state_machine.travel("Walk")
		
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	sprite.offset = set_offset()

	move_and_slide()

func set_offset() -> Vector2:
	var new_offset := Vector2(0, 0)
	
	if sprite.flip_h:
		new_offset.x = -43
	
	if not is_on_floor():
		new_offset.y = 20
		
	return new_offset
