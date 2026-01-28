extends StaticBody3D

@export var mesh: MeshInstance3D

const COLORS := [
	Color.DARK_BLUE,
	Color8(169, 169, 169),
	Color.WHITE,
	Color.YELLOW
]

var color_index := 0
var locked := false


func _ready():
	_update_visual()


func interact(_interactor):
	if locked:
		return

	color_index = (color_index + 1) % COLORS.size()
	_update_visual()


func _update_visual():
	var mat := mesh.get_active_material(0)
	if mat == null:
		return

	mat = mat.duplicate()
	mat.albedo_color = COLORS[color_index]
	mesh.set_surface_override_material(0, mat)


func reset():
	color_index = 0
	locked = false
	_update_visual()


func lock():
	locked = true

func show_temp_color(color: Color, duration := 1.0):
	var tween = create_tween()
	tween.tween_interval(duration)
	tween.tween_callback(func(): reset())
	var mat = mesh.get_active_material(0)
	if mat == null:
		mat = StandardMaterial3D.new()
		mesh.set_surface_override_material(0, mat)

	mat.albedo_color = color
