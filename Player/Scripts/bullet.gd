extends CharacterBody2D

@export var speed = 300
@export var damage = 15

var pos:Vector2
var rota: float
var dir : float

func _ready():
	global_position=pos
	global_rotation=rota

func _physics_process(delta):
	velocity = Vector2(speed,0).rotated(dir)
	move_and_slide()
