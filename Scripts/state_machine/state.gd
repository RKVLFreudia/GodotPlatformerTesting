class_name State extends Node

@export var state_name : String
var state_machine : StateMachine
var player : Player

## Executed once on entering the state
func on_enter() -> void:
	pass
	
## Executed once on exiting the state
func on_exit() -> void:
	pass
	
## Executed every process
func on_update(delta: float) -> void:
	pass
	
## Executed every physics_process
func on_fixed_update(delta: float) -> void:
	if not state_machine.sm_owner.characterbody2d.is_on_floor():
		state_machine.sm_owner.characterbody2d.velocity += \
			state_machine.sm_owner.characterbody2d.get_gravity() * delta

## Executed on every input
func on_input_handle(event: InputEvent) -> void:
	pass
