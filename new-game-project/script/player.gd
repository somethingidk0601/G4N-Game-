extends CharacterBody2D

@export var speed: float = 200.0  # Adjust player speed as needed
var health: int = 100  # Add health for the player

func _physics_process(delta):
	# Movement logic
	var direction = Vector2.ZERO
	if Input.is_action_pressed("ui_up"):
		direction.y -= 1
	if Input.is_action_pressed("ui_down"):
		direction.y += 1
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	
	direction = direction.normalized()
	velocity = direction * speed
	move_and_slide()
	
# Function to handle taking damage
func take_damage(amount: int):
	health -= amount
	print("Player health:", health)
	if health <= 0:
		die()

# Function to handle player death
func die():
	print("Player has died!")
	queue_free()
