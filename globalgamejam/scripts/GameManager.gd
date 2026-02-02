extends Node3D

func _ready():
	MessageManager.show_message(
		"CONTROLES:\n\nWASD - Move\nMouse - Look\nLeft Click - Interact\n\nExplore the enviroment and solve puzzles."
	)
