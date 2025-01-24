extends CharacterBody2D


const SPEED = 300.0
@onready var target = $"../Player"


func _physics_process(delta: float) -> void:
	var direction = (target.position-position).normalized()
	
	velocity = direction * SPEED
	look_at(target.position)

	move_and_slide()
