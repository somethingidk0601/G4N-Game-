extends Node2D

@onready var PauseMenu = $CanvasLayer/PauseWaitAminuteEushaissmellinghisfeet
var paused = false

func _process(delta):
	if Input.is_action_just_pressed("esc"):
		pauseMenu()

func pauseMenu():
	if paused:
		PauseMenu.hide()
		Engine.time_scale = 1 
	else:
		PauseMenu.show()
		Engine.time_scale = 0 
	
	paused = !paused 				
