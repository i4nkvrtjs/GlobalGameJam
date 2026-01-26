extends StaticBody3D

@export var required_color : Color = Color.GREEN
var activated := false

func _on_area_3d_body_entered(body):
	if activated:
		return

	# Sabemos que esto es un objeto interactuable
	if body.current_color == required_color:
		_activate()


func _activate():
	activated = true

	for cube in get_tree().get_nodes_in_group("floating_cubes"):
		print("Activando cubo:", cube.name)
		cube.activate()
