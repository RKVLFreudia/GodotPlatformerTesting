class_name State extends Node

var state_machine : StateMachine
var state_owner : CharacterBody2D
var animation_tree : AnimationNodeStateMachinePlayback

# Executed once on entering the node
func on_enter() -> void:
	pass
	
# Executed once on exiting the node
func on_exit() -> void:
	pass
	
# Executed every process
func on_update(delta: float) -> void:
	pass
	
# Executed every physics_process
func on_fixed_update(delta: float) -> void:
	if not state_owner.is_on_floor():
		state_owner.velocity += state_owner.get_gravity() * delta
