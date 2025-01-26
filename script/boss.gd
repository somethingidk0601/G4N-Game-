extends CharacterBody2D

@export var speed: float = 80.0
@export var max_health: int = 300
@export var attack_damage: int = 15
@export var special_attack_damage: int = 30
@export var attack_cooldown: float = 1.5
@export var special_attack_cooldown: float = 5.0
@export var special_attack_radius: float = 100.0

var health: int = max_health
var last_attack_time: float = 0.0
var last_special_attack_time: float = 0.0
var player_detected = false
var player: Node = null
var is_dying = false  # Prevent interactions during death animation

func _ready():
	# Connect signals for detecting the player
	$Area2D.body_entered.connect(_on_area_entered)
	$Area2D.body_exited.connect(_on_area_exited)
	$AnimatedSprite2D.animation_finished.connect(_on_animation_finished)  # Handle animation end
	
	$HitBox.Damaged.connect( take_damage )
		
	update_health_bar()

func _on_area_entered(body):
	if body.name == "Player":
		player_detected = true
		player = body

func _on_area_exited(body):
	if body.name == "Player":
		player_detected = false
		player = null

func _physics_process(delta):
	# Stop actions if the boss is dying
	if is_dying:
		return

	if player_detected and player:
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * speed
		move_and_slide()
		
		# Attack the player if in range
		attack_player(delta)
	else:
		velocity = Vector2.ZERO
		move_and_slide()
		
		# Play the idle animation when out of range
		if $AnimatedSprite2D.animation != "idle":
			$AnimatedSprite2D.play("idle")

func attack_player(delta: float):
	var current_time = Time.get_ticks_msec() / 1000.0
	if current_time - last_attack_time >= attack_cooldown:
		last_attack_time = current_time
		if player and player.has_method("take_damage"):
			# Play the attack animation
			if $AnimatedSprite2D.animation != "attack":
				$AnimatedSprite2D.play("attack")
			
			# Deal damage to the player
			player.take_damage(attack_damage)

func take_damage(amount: int) -> void:
	if is_dying:
		return  # Ignore damage while dying

	health -= amount
	health = clamp(health, 0, max_health)  # Ensure health is within bounds
	update_health_bar()

	if health <= 0:
		die()

func update_health_bar() -> void:
	$ProgressBar.value = health

func die() -> void:
	is_dying = true  # Prevent further actions
	$AnimatedSprite2D.play("dead")  # Play the death animation

func _on_animation_finished():
	# Check if the finished animation is the "dead" animation
	if $AnimatedSprite2D.animation == "dead" and is_dying:
		queue_free()  # Remove the boss from the scene
