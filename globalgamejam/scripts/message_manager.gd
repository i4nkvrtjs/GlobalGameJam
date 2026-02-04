extends Node

var ui: CanvasLayer

func register_ui(message_ui: CanvasLayer):
	ui = message_ui

func show_message(text: String, on_close = null):
	ui.show_message(text, on_close)

func show_win_image(texture: Texture2D, on_close = null):
	ui.show_win_image(texture, on_close)
