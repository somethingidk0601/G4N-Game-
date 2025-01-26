class_name State extends Node

#This State belongs to Player
static var player: Player

func _ready() -> void:
	pass # Replace with function body.

#What happens when player enters this State?
func Enter() -> void:
	pass
	

#What happens when player exits this State?
func Exit() -> void:
	pass

#What happens during the _process
func Process( _delta: float) -> State:
	return null
	
#What happens during the _physics_process update 
func Physics( _delta: float) -> State:
	return null
	
#What happens with input envents in this State
func HandleInput( _event: InputEvent) -> State:
	return null
