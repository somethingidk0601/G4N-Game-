class_name Player extends CharacterBody2D

var cardinal_direction : Vector2 = Vector2.DOWN
const DIR_4 = [ Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP ]
var direction : Vector2 = Vector2.ZERO

var health: int = 100
var max_health: int = 100

@onready var health_bar = $ProgressBar

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D = $Sprite2D
@onready var state_machine : PlayerStateMachine = $StateMachine

signal DirectionChanged( new_direction: Vector2 )

# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerManager.player = self
	state_machine.Initialize(self)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process( delta ):
	#direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	#direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	direction = Vector2(
		Input.get_axis("left", "right"),
		Input.get_axis("up","down")
	).normalized()
	pass

func _physics_process(delta):
	move_and_slide()
	
func calculate_direction_index(direction: Vector2, cardinal_direction: Vector2, dir_size: int) -> int:
	var direction_bias = 0.1
	var angle = (direction + cardinal_direction * direction_bias).angle()
	var normalized_angle = angle / TAU
	var direction_idx = int(round(normalized_angle * dir_size))
	return direction_idx
	
func SetDirection() -> bool :
	if direction == Vector2.ZERO:
		return false
	
	var direction_idx: int = calculate_direction_index(direction, cardinal_direction, DIR_4.size())
	var new_dir = DIR_4[ direction_idx ]
	
	if new_dir == cardinal_direction:
		return false
		
	cardinal_direction = new_dir
	DirectionChanged.emit(new_dir)
	sprite.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1
	return true


func UpdateAnimation(state : String) -> void:
	animation_player.play( state + "_" + AnimDirection())
	pass

func AnimDirection() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"
	else:
		return "side"

func take_damage(amount: int) -> void:
	health -= amount
	health = clamp(health, 0, max_health)
	update_health_bar()
	if health <= 0:
		die()

func update_health_bar() -> void:
	if health_bar:
		health_bar.value = health

func die() -> void:
	queue_free()
