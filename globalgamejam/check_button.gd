extends StaticBody3D

@export var puzzle_path : NodePath

func interact(_interactor):
	get_node(puzzle_path).check_solution()
