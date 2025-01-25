extends Node2D

@export var speed = 300
@export var damage = 15
@onready var bullet_box : BulletBox = $BulletBox

func _process(delta: float) -> void:
	position += transform.x * speed * delta


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
