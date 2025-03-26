class_name Player extends Node

# Base stats
const WALK_SPEED : float = 300.0
const SPRINT_SPEED_MULT : float = 1.6
const JUMP_VELOCITY : float = -400.0

@onready var animation_tree : AnimationNodeStateMachinePlayback = \
	$AnimationTree["parameters/playback"]
@onready var characterbody2d : CharacterBody2D = $"."
@export var state_machine : StateMachine

# DEBUG ================
const FLIP_OFFSET_H := Vector2(-43, 0)
@export var sprite : Sprite2D
@export var state_label : Label
