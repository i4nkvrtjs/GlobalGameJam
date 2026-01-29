extends Node3D

@export var buttons: Array[Node]

var solved := false


func _process(_delta):
	if solved:
		return

	var all_pressed := true

	for b in buttons:
		if not b.pressed:
			all_pressed = false
			break

	if all_pressed:
		_solve()


func _solve():
	solved = true
	print("PUZZLE DE BOTONES RESUELTO")
	for cube in get_tree().get_nodes_in_group("floating_cubes"):
		print("Activando cubo:", cube.name)
		cube.activate()
