class_name BulletBox extends Area2D

@export var damage : int = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	if not is_connected("area_entered", Callable(self, "AreaEntered")):
		area_entered.connect(AreaEntered)
	monitoring = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func AreaEntered( a : Area2D ) -> void:
	print("Bullet hit: ", a.name)
	if a is HitBox:
		var bubble = a.get_parent()
		if bubble and bubble is Bubble:
			bubble.TakeDamage(damage)
			print("Bullet hit a bubble!")
		queue_free()
		get_parent().queue_free()
	pass
