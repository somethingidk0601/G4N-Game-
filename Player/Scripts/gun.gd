extends Node2D 

@export var shootSpeed = 1.0
const bulletPath = preload( "res://Player/Gun/Bullet.tscn" )

@onready var bow: Marker2D = $Marker2D
@onready var shoot_speed_timer = $Timer

var canShoot = true

func _ready():
	shoot_speed_timer.wait_time = 0.20 / shootSpeed

func _process(delta):
	if canShoot:
		canShoot = false
		shoot_speed_timer.start()
		look_at(get_global_mouse_position())
		
		rotation_degrees = wrap(rotation_degrees,0,360)
		if rotation_degrees > 90 and rotation_degrees < 270:
			scale.y =-1
		else:
			scale.y = 1
		
		if Input.is_action_pressed("Click"):
			$".".visible = true
			var bullet_instance = bulletPath.instantiate()
			get_tree().root.add_child(bullet_instance)
			bullet_instance.global_position = bow.global_position
			bullet_instance.rotation = rotation
		else:
			$".".visible = false
		pass


func _on_timer_timeout():
	canShoot = true
