extends Area3D

@export var images: Array[Texture2D]   # recursos externos
@export var image_index := 0
@export var manager : Node

@onready var mesh: MeshInstance3D = $MeshInstance3D

func _ready():
	_update_image()

func interact(_interactor):
	if images.is_empty():
		return

	image_index = (image_index + 1) % images.size()
	_update_image()

	if manager:
		manager.check_solution()

func _update_image():
	var mat := mesh.get_active_material(0)

	if mat == null:
		return

	mat = mat.duplicate()
	mat.albedo_texture = images[image_index]
	mesh.set_surface_override_material(0, mat)
