class_name CreepStateMachine extends Node

var states : Array[ CreepState ]
var prev_state : CreepState
var current_state : CreepState


func _ready():
	process_mode = Node.PROCESS_MODE_DISABLED
	pass 

func initialize( _creep : Creep ) -> void:
	states = []
	
	for c in get_children():
		if c is CreepState:
			states.append(c)
	
	for s in states:
		s.creep = _creep
		s.state_machine = self
		s.init()
	
	if states.size() > 0:
		change_state(states[0])
		process_mode = Node.PROCESS_MODE_INHERIT
	pass

func _process(delta):
	change_state( current_state.process(delta) )
	pass
	
func _physics_process(delta):
	change_state( current_state.Physics(delta))
	pass

func change_state( new_state : CreepState) -> void:
	if new_state == null || new_state == current_state:
		return
		
	if current_state:
		current_state.exit()
		
	prev_state = current_state
	current_state =new_state
	current_state.enter()
