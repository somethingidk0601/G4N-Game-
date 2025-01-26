class_name Creep extends CharacterBody2D

signal direction_changed( new_dicrection : Vector2)
signal creep_damaged()
signal creep_destroyed()

var cardinal_direction : Vector2 = Vector2.DOWN
const DIR_4 = [ Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP ]
var direction : Vector2 = Vector2.ZERO

@export var hp : int = 3

var player : Player
var invulnerable : bool = false

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D = $Sprite2D
@onready var hit_box : HitBox = $HitBox
@onready var state_machine : CreepStateMachine = $CreepStateMachine

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	state_machine.initialize(self)
	player = PlayerManager.player
	hit_box.Damaged.connect(_take_damage )
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _physics_process(delta):
	move_and_slide()


func set_direction( _new_direction : Vector2) -> bool :
	direction = _new_direction
	if direction == Vector2.ZERO:
		return false
	
	
	var direction_id: int = int( round( ( direction + cardinal_direction *0.1 ).angle() / TAU * DIR_4.size() ) )
	var new_dir = DIR_4[ direction_id ]
	
	if new_dir == cardinal_direction:
		return false
		
	cardinal_direction = new_dir
	direction_changed.emit(new_dir)
	sprite.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1
	return true

func update_animation(state : String) -> void:
	animation_player.play( state + "_" + AnimDirection())
	pass

func AnimDirection() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"
	else:
		return "side"

func _take_damage(damage : int) -> void:
	if invulnerable == true:
		return
	hp -= damage
	if hp > 0:
		creep_damaged.emit()
	else:
		creep_destroyed.emit()
