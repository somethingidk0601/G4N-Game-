extends CharacterBody2D

@export var speed = 400
@onready var gun = $Gun

var direction = Vector2.ZERO

#func get_input():
	#var input_direction = Input.get_vector("Left","Right","Forward","Down")
	#velocity = input_direction * speed 
	
func _physics_process(delta):
	
	if Input.is_action_pressed("Click"):
		gun.shoot()
		
	direction.x = Input.get_axis("Left","Right")
	direction.y = Input. get_axis("Forward",'Down')
	if direction:
		velocity = direction * speed 
	else: 
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.y = move_toward(velocity.x, 0, speed)
	
	if direction != Vector2.ZERO:
		gun.setup_direction(direction)	

	move_and_slide()
