class_name Bubble extends Node2D

@export var enemy_scene1 = preload("res://scene/ghost.tscn")
@export var enemy_scene2 = preload("res://scene/critter.tscn")
@export var enemy_scene3 = preload("res://Enemies/Creep/creep.tscn")

var has_taken_damage = false  # Prevent multiple executions

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HitBox.Damaged.connect( TakeDamage )
	pass # Replace with function body.


func TakeDamage( _damage: int) -> void:
	if has_taken_damage:
		return  # Stop if already triggered
	has_taken_damage = true
	print("Bubble destroyed")
	spawn_random_enemy()
	$HitBox.queue_free()
	queue_free()
	
	pass

func spawn_random_enemy():
	var random_choice = randi() % 4 # 0: Nothing, 1: Enemy1, 2: Enemy2
	var enemy_instance = null

	match random_choice:
		1:
			enemy_instance = enemy_scene1.instantiate()
		2:
			enemy_instance = enemy_scene2.instantiate()
		3:
			enemy_instance = enemy_scene3.instantiate()

	if enemy_instance:
		enemy_instance.position = self.position
		get_parent().add_child(enemy_instance)
		
		if enemy_instance.has_method("set_velocity"):
			enemy_instance.set_velocity(Vector2.ZERO)
	
	enemy_instance = null
