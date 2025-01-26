class_name CreepStateMachine extends Node

var states : Array[ CreepState ]
var prev_state : CreepState
var current_state : CreepState


func _ready():
	process_mode = Node.PROCESS_MODE_DISABLED
	pass 



func _process(delta):
	
	pass

func change_state( new_state : CreepState) -> void:
	if new_state == null || new_state == current_state:
		return
		
	if current_state:
		current_state.exit()
		
	prev_state = current_state
	current_state =new_state
	current_state.enter()
