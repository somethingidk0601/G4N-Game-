class_name Bubble extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HitBox.Damaged.connect( TakeDamage )
	pass # Replace with function body.


func TakeDamage( _damage: int) -> void:
	queue_free()
	pass
