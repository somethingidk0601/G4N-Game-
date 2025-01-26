class_name CreepStateWander extends CreepState

@export var anim_name : String = "walk"
@export var wander_speed : float = 20.0

@export_category("AI")
@export var state_animation_duration : float = 0.7
@export var state_cycles_min : int = 1
@export var state_cycles_max : int = 3
@export var next_state : CreepState

var _timer : float = 0.0
var _direction : Vector2

#What happens when we initialize this state?
func init() -> void:
	pass

#What happens when creep enters this State?
func enter() -> void:
	_timer = randi_range( state_cycles_min, state_cycles_max) * state_animation_duration
	var rand = randi_range( 0, 3)
	_direction = creep.DIR_4[ rand ]
	creep.velocity = _direction * wander_speed
	creep.set_direction(_direction)
	creep.update_animation( anim_name)
	pass
	

#What happens when creep exits this State?
func exit() -> void:
	pass

#What happens during the _process
func process( _delta: float) -> CreepState:
	_timer -= _delta
	if _timer <= 0:
		return next_state
	return null
	
#What happens during the _physics_process update 
func Physics( _delta: float) -> CreepState:
	return null
