extends CharacterBody2D 

@export var shootSpeed = 1.0
const bulletPath = preload( "res://Player/Gun/Bullet.tscn" )

@onready var shoot_speed_timer = $Timer

var canShoot = true

func _ready():
	shoot_speed_timer.wait_time = 0.24 / shootSpeed

func _process(delta):
	$Node2D.look_at(get_global_mouse_position())
	if Input.is_action_pressed("Click"):
		$".".visible = true
		$".".shoot()
	else:
		$".".visible = false
	pass

func shoot():
	if canShoot:
		canShoot = false
		shoot_speed_timer.start()
		var bullet = bulletPath.instantiate()
		
		bullet.dir=$Node2D/Marker2D.global_rotation
		bullet.pos=$Node2D/Marker2D.global_position
		bullet.rota=$Node2D/Marker2D.global_rotation
	
		get_parent().add_child(bullet)
		
func _on_timer_timeout():
	canShoot = true
