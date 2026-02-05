extends Node3D
@onready var musica_presente: AudioStreamPlayer = $MusicaPresente

func _ready():
	MessageManager.show_message(
		"CONTROLES:\n\nWASD - Move\nMouse - Look\nLeft Click - Interact\n\nExplore the enviroment and solve puzzles."
	)
	musica_presente.play()
