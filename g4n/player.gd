extends CharacterBody2D

@export var MAX_SPEED = 300
@export var ACCELERATION = 1500
@export var FRICTION = 1200

@onready var axis = Vector2.ZERO



func _physics_process(delta: float) -> void:
	move(delta)
	

func get_input_axis():
	axis.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	axis.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
	
	return axis.normalized()
	
func move(delta: float) -> void:
	axis = get_input_axis()
	
	if axis == Vector2.ZERO:
		apply_friction(FRICTION * delta)
	
	else:
		apply_movement(axis * ACCELERATION * delta)
		
	move_and_slide()
	
func apply_friction(amount):
	if velocity.length() > amount:
		velocity -= velocity.normalized() * amount
		
	else:
		velocity = Vector2.ZERO
		
		
func apply_movement(accel):
	velocity += accel
	velocity = velocity.limit_length(MAX_SPEED)
	
	
	
	
#extends CharacterBody2D
#
#@export var MAX_SPEED = 300
#@export var ACCELERATION = 1500
#@export var FRICTION = 1200
#
#@onready var weapon_node = $Weapon
#var axis = Vector2.ZERO
#
#func _physics_process(delta: float) -> void:
	#handle_input(delta)
	#move_and_slide()
#
#func handle_input(delta: float):
	#axis = get_input_axis()
	#if axis != Vector2.ZERO:
		#apply_movement(axis * ACCELERATION * delta)
	#else:
		#apply_friction(FRICTION * delta)
#
	#if Input.is_action_just_pressed("mouse_attack"):
		#print("Mouse clicked for attack")  # Debugging
		#attack()
#
#func get_input_axis() -> Vector2:
	#axis.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	#axis.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
	#return axis.normalized()
#
#func apply_friction(amount):
	#if velocity.length() > amount:
		#velocity -= velocity.normalized() * amount
	#else:
		#velocity = Vector2.ZERO
#
#func apply_movement(accel: Vector2):
	#velocity += accel
	#velocity = velocity.limit_length(MAX_SPEED)
#
#func attack():
	#if weapon_node:
		#weapon_node.start_attack()
