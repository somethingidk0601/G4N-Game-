extends Node2D

@export var shootSpeed = 1.0
const Bullet = preload( "res://Player/Gun/Bullet.tscn" )

@onready var marker_2d = $Marker2D
@onready var shoot_speed_timer = $Timer

var canShoot = true
var bulletDirection = Vector2(1,0)

func _ready():
	shoot_speed_timer.wait_time = 0.24 / shootSpeed

func shoot():
	if canShoot:
		canShoot = false
		shoot_speed_timer.start()
		
		var bulletNode = Bullet.instantiate()
		
		bulletNode.set_direction(bulletDirection)
		get_tree().root.add_child(bulletNode)
		bulletNode.global_position = marker_2d.global_position


func _on_timer_timeout():
	canShoot = true
	
func setup_direction(direction):
	bulletDirection = direction
	
	if direction.x > 0 :
		scale.x = 1
		rotation_degrees = 0
	elif direction.x < 0:
		scale.x = -1 
		rotation_degrees = 0
	elif direction.y < 0:
		scale.x = 1 
		rotation_degrees = -90
	elif direction.y > 0:
		scale.x = 1 
		rotation_degrees = 90				
	
