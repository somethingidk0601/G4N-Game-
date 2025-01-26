class_name Bubble extends Node2D



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HitBox.Damaged.connect( TakeDamage )
	pass # Replace with function body.


func TakeDamage( _damage: int) -> void:
	print("Bubble destroyed")
	$HitBox.queue_free()
	queue_free()
	
	pass
