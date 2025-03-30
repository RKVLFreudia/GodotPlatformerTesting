class_name Player extends Node

# Base stats
const WALK_SPEED : float = 300.0
const SPRINT_SPEED_MULT : float = 1.6

const JUMP_VELOCITY : float = -550.0

const WALK_ACCELERATION : float = 10.0
const SPRINT_ACCELERATION : float = 50.0

const WALK_DECCELERATION : float = 50.0
const SPRINT_DECCELERATION : float = 75.0

# AERIAL =====================
const WALK_AERIAL_SPEED : float = 250.0
const SPRINT_AERIAL_SPEED : float = 350.0

# TEST ======================
var last_target_speed : float = 0.0

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var animation_tree : AnimationNodeStateMachinePlayback = \
	$AnimationTree["parameters/playback"]
@onready var characterbody2d : CharacterBody2D = $"."
@export var state_machine : StateMachine

# DEBUG ================
const FLIP_OFFSET_H := Vector2(-43, 0)
@export var sprite : Sprite2D
@export var state_label : Label
@export var is_double_tap_label : Label
@export var h_velocity_label : Label
@export var v_velocity_label : Label
@export var last_registered_tap_detection : Label

func set_flip_h(do_flip: bool) -> void:
	if do_flip:
		sprite.offset = FLIP_OFFSET_H
		sprite.flip_h = true
	else:
		sprite.offset = Vector2.ZERO
		sprite.flip_h = false

func _process(delta: float) -> void:
	if state_label:
		state_label.text = "State: " + state_machine.current_state.state_name
	if is_double_tap_label: 
		is_double_tap_label.text = "Is Double Tap: " + str(state_machine.input_controller.is_double_tap)
	if h_velocity_label: 
		h_velocity_label.text = "X Speed: " + str(characterbody2d.velocity.x)
	if v_velocity_label: 
		v_velocity_label.text = "Y Speed: " + str(roundf(characterbody2d.velocity.y))
	if last_registered_tap_detection: 
		last_registered_tap_detection.text = "Last Key Tap: " + str(state_machine.input_controller.last_key_pressed)

# ======================
