extends CharacterBody2D

@export var speed: float = 100.0
@export var attack_damage: int = 10
@export var attack_cooldown: float = 1.0
var player_detected = false
var player: Node = null
var last_attack_time: float = 0.0

func _ready():
	$Area2D.connect("body_entered", Callable(self, "_on_area_entered"))
	$Area2D.connect("body_exited", Callable(self, "_on_area_exited"))

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
