extends CharacterBody2D

@export var speed: float = 200.0
@export var attack_damage: int = 20  # Added attack damage
@export var attack_cooldown: float = 0.5  # Added attack cooldown

var health: int = 100
var max_health: int = 100
var last_attack_time: float = 0.0  # Track last attack time

@onready var health_bar = $ProgressBar

func _physics_process(delta: float) -> void:
	var direction = Vector2.ZERO
	if Input.is_action_pressed("ui_up"):
		direction.y -= 1
	if Input.is_action_pressed("ui_down"):
		direction.y += 1
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	
	# Attack when space is pressed
	if Input.is_action_just_pressed("ui_attack"):  # Assumes you've set up "ui_attack" in Input Map as Spacebar
		attack_enemies()
	
	direction = direction.normalized()
	velocity = direction * speed
	move_and_slide()

func attack_enemies() -> void:
	var current_time = Time.get_ticks_msec() / 1000.0
	if current_time - last_attack_time >= attack_cooldown:
		last_attack_time = current_time
		
		# Find all bodies in attack range (you'll need to add an Area2D to detect nearby enemies)
		var overlapping_bodies = $AttackArea.get_overlapping_bodies()
		for body in overlapping_bodies:
			if body.has_method("take_damage"):
				body.take_damage(attack_damage)

func take_damage(amount: int) -> void:
	health -= amount
	health = clamp(health, 0, max_health)
	update_health_bar()
	if health <= 0:
		die()

func update_health_bar() -> void:
	if health_bar:
		health_bar.value = health

func die() -> void:
	queue_free()
