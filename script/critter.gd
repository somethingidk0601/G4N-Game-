extends CharacterBody2D

@export var speed: float = 100.0
@export var attack_damage: int = 10
@export var attack_cooldown: float = 1.0
@export var max_health: int = 1  # Added max health
@export var health: int = max_health  # Set initial health to max health

@onready var health_bar = $ProgressBar  # Reference to the ProgressBar node
@onready var animated_sprite = $AnimatedSprite2D  # Reference to the AnimatedSprite2D node

var player_detected = false
var player: Node = null
var last_attack_time: float = 0.0
var is_dying = false  # Prevent actions during death animation

func _ready():
	$Area2D.connect("body_entered", Callable(self, "_on_area_entered"))
	$Area2D.connect("body_exited", Callable(self, "_on_area_exited"))
	$AnimatedSprite2D.animation_finished.connect(_on_animation_finished)  # Handle animation end

	$HitBox.Damaged.connect( take_damage )
	
	# Initialize health bar
	if health_bar:
		health_bar.max_value = max_health
		health_bar.value = health  # Set initial health value on the bar

func _on_area_entered(body):
	if body.name == "Player":
		player_detected = true
		player = body

func _on_area_exited(body):
	if body.name == "Player":
		player_detected = false
		player = null

func _physics_process(delta):
	# Stop actions if the critter is dying
	if is_dying:
		return

	if player_detected and player:
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * speed
		move_and_slide()

		# Play the move animation
		if animated_sprite.animation != "move":
			animated_sprite.play("move")
		
		# Attempt to attack the player
		attack_player(delta)
	else:
		velocity = Vector2.ZERO
		move_and_slide()

		# Play the idle animation when not moving or out of range
		if animated_sprite.animation != "idle":
			animated_sprite.play("idle")

# Attack logic
func attack_player(delta: float):
	var current_time = Time.get_ticks_msec() / 1000.0  # Get current time in seconds
	if current_time - last_attack_time >= attack_cooldown:
		last_attack_time = current_time
		if player.has_method("take_damage"):  # Ensure the player can take damage
			# Play the attack animation
			if animated_sprite.animation != "attack":
				animated_sprite.play("attack")
			
			# Deal damage to the player
			player.take_damage(attack_damage)

# Function to take damage
func take_damage(amount: int) -> void:
	if is_dying:
		return  # Ignore damage while dying

	health -= amount
	health = clamp(health, 0, max_health)  # Make sure health doesn't go below 0
	update_health_bar()  # Update health bar display

	if health <= 0:
		die()

# Function to update health bar
func update_health_bar() -> void:
	if health_bar:
		health_bar.value = health  # Set the health bar's value to current health

# Die function to remove the critter when health reaches zero
func die() -> void:
	is_dying = true  # Prevent further actions
	animated_sprite.play("dead")  # Play the death animation

# Animation finished callback
func _on_animation_finished():
	# Check if the finished animation is the "dead" animation
	if animated_sprite.animation == "dead" and is_dying:
		queue_free()  # Remove the critter from the scene
