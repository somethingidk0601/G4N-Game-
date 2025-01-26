class_name Critter extends CharacterBody2D

@export var speed: float = 150.0
@export var attack_damage: int = 10
@export var attack_cooldown: float = 1.0
@export var max_health: int = 1  # Added max health
@export var health: int = max_health  # Set initial health to max health

@onready var health_bar = $ProgressBar  # Reference to the ProgressBar node

var player_detected = false #vulnerable
var player: Node = null #Player
var last_attack_time: float = 0.0

func _ready():
	$Area2D.connect("body_entered", Callable(self, "_on_area_entered"))
	$Area2D.connect("body_exited", Callable(self, "_on_area_exited"))

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
	if player_detected and player:
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * speed
		move_and_slide()

		# Attempt to attack the player
		attack_player(delta)
	else:
		velocity = Vector2.ZERO
		move_and_slide()

# Attack logic
func attack_player(delta: float):
	var current_time = Time.get_ticks_msec() / 1000.0  # Get current time in seconds
	if current_time - last_attack_time >= attack_cooldown:
		last_attack_time = current_time
		if player.has_method("take_damage"):  # Ensure the player can take damage
			player.take_damage(attack_damage)

# Function to take damage
func take_damage(amount: int) -> void:
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
	queue_free()  # Remove the critter from the scene
