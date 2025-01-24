extends CharacterBody2D

@export var speed: float = 200.0
var health: int = 100
var max_health: int = 100

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

	direction = direction.normalized()
	velocity = direction * speed
	move_and_slide()

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
