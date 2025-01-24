#extends Area2D
#
#
#
#func attack():
	#$AnimationPlayer.play("attack")
	
#
#extends Area2D
#
#@export var ATTACK_DURATION = 0.3
#@onready var collision_shape = $CollisionShape2D
#@onready var animation_player = $AnimationPlayer
#
#func _ready():
	#collision_shape.disabled = true
#
#func start_attack():
	#if animation_player and not animation_player.is_playing():
		#print("Starting attack animation")  # Debugging
		#collision_shape.disabled = false
		#animation_player.play("attack")
		#await get_tree().create_timer(ATTACK_DURATION).timeout
		#collision_shape.disabled = true
#
#func _on_body_entered(body):
	#if body.is_in_group("enemies"):
		#print("Enemy hit!")  # Debugging
		#body.take_damage(10)
