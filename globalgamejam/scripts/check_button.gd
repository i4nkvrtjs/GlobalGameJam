extends StaticBody3D

@export var puzzle_path: NodePath
@export var future_puzzle_path: NodePath

func interact(_interactor):
	if puzzle_path != NodePath():
		var puzzle = get_node(puzzle_path)
		if puzzle and puzzle.has_method("check_solution"):
			puzzle.check_solution()

	if future_puzzle_path != NodePath():
		var future_puzzle = get_node(future_puzzle_path)
		if future_puzzle and future_puzzle.has_method("on_check_pressed"):
			future_puzzle.on_check_pressed()
