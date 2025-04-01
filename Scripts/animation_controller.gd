class_name AnimationController extends Node

enum AnimationType { 
	IDLE, 
	WALK, 
	SPRINT, 
	SLIDE, 
	JUMP, 
	FALL,
	FALL_EXIT, 
}

var _animations : Dictionary[AnimationType, String] = {
	AnimationType.IDLE:		"Idle",
	AnimationType.WALK:		"Walk",
	AnimationType.SPRINT:	"Sprint",
	AnimationType.SLIDE:	"Slide",
	AnimationType.JUMP:		"Jump_entry",
	AnimationType.FALL:		"jump_falling",
	AnimationType.FALL_EXIT:"jump_exit",
}

@onready var _animation_tree_playback : AnimationNodeStateMachinePlayback = \
		$"../AnimationTree"["parameters/playback"]
@onready var _animation_tree : AnimationTree = $"../AnimationTree"

var previous_animation_not_breakable = false

func request_travel(animation: AnimationType, breakable: bool = true, forcefulbreak : bool = false) -> bool:
	if not _animations.has(animation): return false
	if forcefulbreak: previous_animation_not_breakable = false
	
	if previous_animation_not_breakable:
		await _animation_tree.animation_finished
		previous_animation_not_breakable = false
		
	if not breakable: previous_animation_not_breakable = true
	_animation_tree_playback.travel(_animations[animation])
	return true

func request_travel_string(animation: String, break_previous: bool = true) -> bool:
	_animation_tree_playback.travel(animation)
	return true
