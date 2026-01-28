extends StaticBody3D

signal tile_pressed(tile_index)

@export var tile_index := 0
@export var press_offset := Vector3(-0.05, 0, 0)

var original_position: Vector3
var pressed := false

func _ready():
	original_position = global_position

func interact(_interactor):
	if pressed:
		return

	pressed = true
	global_position += press_offset
	emit_signal("tile_pressed", tile_index)

func reset():
	pressed = false
	global_position = original_position
