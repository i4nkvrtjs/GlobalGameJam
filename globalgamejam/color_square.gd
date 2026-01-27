extends StaticBody3D
class_name ColorSquare

signal color_changed

var colors := [
	Color.WHITE,
	Color.GREEN,
	Color.YELLOW,
	Color.ORANGE
]

var color_index := 0
var current_color : Color

@onready var mesh := $MeshInstance3D

func _ready():
	_update_color()

func interact(_interactor):
	color_index = (color_index + 1) % colors.size()
	_update_color()
	emit_signal("color_changed")

func _update_color():
	current_color = colors[color_index]

	var mat = mesh.get_active_material(0)
	if mat == null:
		mat = StandardMaterial3D.new()
		mesh.set_surface_override_material(0, mat)

	mat.albedo_color = current_color
