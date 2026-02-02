extends CanvasLayer

@onready var panel := $Panel
@onready var message_text := $Panel/MessageText
@onready var win_image := $Panel/WinImage
@onready var continue_button := $Panel/Button

var callback = null

func _ready():
	hide_all()
	continue_button.pressed.connect(_on_continue_pressed)
	MessageManager.register_ui(self)
	
func show_message(text: String, on_close = null):
	message_text.text = text
	win_image.visible = false
	callback = on_close
	panel.visible = true
	get_tree().paused = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func show_win_image(texture: Texture2D, on_close = null):
	message_text.text = ""
	win_image.texture = texture
	win_image.visible = true
	callback = on_close
	panel.visible = true
	get_tree().paused = true

func hide_all():
	panel.visible = false
	get_tree().paused = false

func _on_continue_pressed():
	hide_all()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	if callback:
		callback.call()
