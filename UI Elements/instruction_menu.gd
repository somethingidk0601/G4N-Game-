extends Control

# Called when the node enters the scene tree for the first time.

func _on_texture_button_pressed() -> void:
	get_tree().change_scene_to_file("res://UI Elements/Menu Scren Modified.tscn")
