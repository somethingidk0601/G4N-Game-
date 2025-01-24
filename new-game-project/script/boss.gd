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

func _ready():
	$Area2D.body_entered.connect(_on_area_entered)
	$Area2D.body_exited.connect(_on_area_exited)

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
		attack_player(delta)
		await special_attack(delta)
	else:
		velocity = Vector2.ZERO
		move_and_slide()

func attack_player(delta: float):
	var current_time = Time.get_ticks_msec() / 1000.0
	if current_time - last_attack_time >= attack_cooldown:
		last_attack_time = current_time
		if player and player.has_method("take_damage"):
			player.take_damage(attack_damage)

func special_attack(delta: float) -> void:
	var current_time = Time.get_ticks_msec() / 1000.0
	if current_time - last_special_attack_time >= special_attack_cooldown:
		last_special_attack_time = current_time
		$SpecialAttackArea.visible = true
		await get_tree().create_timer(0.5).timeout
		$SpecialAttackArea.visible = false
		if player and (player.global_position - global_position).length() <= special_attack_radius:
			if player.has_method("take_damage"):
				player.take_damage(special_attack_damage)

func take_damage(amount: int) -> void:
	health -= amount
	health = clamp(health, 0, max_health)
	update_health_bar()
	if health <= 0:
		die()

func update_health_bar() -> void:
	$ProgressBar.value = health

func die() -> void:
	queue_free()
