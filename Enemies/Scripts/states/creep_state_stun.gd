class_name CreepStateStun extends CreepState

@export var anim_name : String = "stun"
@export var knockback_speed : float = 200.0
@export var decelerate_speed : float = 10.0

@export_category("AI")
@export var next_state : CreepState

var _direction : Vector2
var _animation_finished : bool = false

#What happens when we initialize this state?
func init() -> void:
	creep.creep_damaged.connect(_on_creep_damaged)
	pass

#What happens when creep enters this State?
func enter() -> void:
	creep.invulnerable = true
	_animation_finished = false
	
	_direction = creep.global_position.direction_to( creep.player.global_position )
	
	creep.set_direction(_direction)
	creep.velocity = _direction * -knockback_speed
	
	creep.update_animation( anim_name)
	creep.animation_player.animation_finished.connect( _on_animation_finished )
	pass
	

#What happens when creep exits this State?
func exit() -> void:
	creep.invulnerable = false
	creep.animation_player.animation_finished.disconnect( _on_animation_finished )
	pass

#What happens during the _process
func process( _delta: float) -> CreepState:
	if _animation_finished == true:
		return	next_state
	creep.velocity -= creep.velocity * decelerate_speed * _delta
	return null
	
#What happens during the _physics_process update 
func Physics( _delta: float) -> CreepState:
	return null

func _on_creep_damaged() -> void:
	state_machine.change_state( self )
	

func _on_animation_finished(_a : String) -> void:
	_animation_finished = true
