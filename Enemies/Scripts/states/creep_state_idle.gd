class_name CreepStateIdle extends CreepState

@export var anim_name : String = "idle"

@export_category("AI")
@export var state_duration_min : float = 0.5
@export var state_duration_max : float = 1.5
@export var after_idle_state : CreepState

var _timer : float = 0.0

#What happens when we initialize this state?
func _init() -> void:
	pass

#What happens when creep enters this State?
func enter() -> void:
	creep.velocity = Vector2.ZERO
	_timer = randf_range(state_duration_min, state_duration_max)
	creep.update_animation( anim_name )
	pass
	

#What happens when creep exits this State?
func exit() -> void:
	pass

#What happens during the _process
func process( _delta: float) -> CreepState:
	_timer -= _delta
	if _timer <= 0:
		return after_idle_state
	return null
	
#What happens during the _physics_process update 
func Physics( _delta: float) -> CreepState:
	return null
