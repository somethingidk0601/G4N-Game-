class_name State_Walk extends State

@export var move_speed : float = 200.0

@onready var idle : State = $"../Idle"
@onready var attack: State = $"../Attack"

#What happens when player enters this State?
func Enter() -> void:
	player.UpdateAnimation("walk")
	pass
	

#What happens when player exits this State?
func Exit() -> void:
	pass

#What happens during the _process
func Process( _delta: float) -> State:
	if player.direction == Vector2.ZERO:
		return idle
	
	player.velocity = player.direction * move_speed
	
	if player.SetDirection():
		player.UpdateAnimation("walk")

	return null
	
#What happens during the _physics_process update 
func Physics( _delta: float) -> State:
	return null
	
#What happens with input envents in this State
func HandleInput( _event: InputEvent) -> State:
	if _event.is_action_pressed("attack"):
		return attack
	return null
