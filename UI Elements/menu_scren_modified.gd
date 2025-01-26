extends Control

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/game.tscn")


func _on_instruction_pressed() -> void:
	get_tree().change_scene_to_file("res://UI Elements/Instruction Menu.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
