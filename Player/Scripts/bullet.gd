extends Area2D

@export var speed = 700
@export var damage = 15

var pos:Vector2
var rota:float
var dir: float

var direction:Vector2

func _ready():
	await get_tree().create_timer(3).timeout
	queue_free()

func set_direction(bulletDirection):
	direction = bulletDirection
	rotation_degrees = rad_to_deg(global_position.angle_to_point(global_position+direction))
	
func _physics_process(delta):
	global_position += direction * speed * delta
		

#func _on_body_entered(body: Node2D) -> void:
	#if body.is.in_group("enemies"):
		#body.get_damaged(damage)
		#queue_free() 
