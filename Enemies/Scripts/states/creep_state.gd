class_name CreepState extends Node

var creep : Creep
var state_machine : CreepStateMachine


#What happens when we initialize this state?
func init() -> void:
	pass

#What happens when creep enters this State?
func enter() -> void:
	pass
	

#What happens when creep exits this State?
func exit() -> void:
	pass

#What happens during the _process
func process( _delta: float) -> CreepState:
	return null
	
#What happens during the _physics_process update 
func Physics( _delta: float) -> CreepState:
	return null
