extends Node

@export var pillars: Array[NodePath]
@export var solution := [2, 5, 9]

var solved := false

func check_solution():
	if solved:
		return

	for i in range(pillars.size()):
		var pillar = get_node(pillars[i])
		if pillar.image_index != solution[i]:
			return

	_solve()

func _solve():
	solved = true
	print("Puzzle pilares resuelto")
	for cube in get_tree().get_nodes_in_group("floating_cubes"):
		print("Activando cubo:", cube.name)
		cube.activate()
