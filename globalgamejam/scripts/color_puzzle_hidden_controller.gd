extends Node3D

@export var buttons: Array[Node]
@export var solution := [
	0, 0, 0, 0,
	0, 2, 3, 3,
	3, 3, 1, 3
]

@export var auto_resolve := true

var solved := false


func _ready():
	assert(buttons.size() == solution.size())
	print("Puzzle listo con", buttons.size(), "botones")


func check_solution():
	if solved:
		return

	for i in range(buttons.size()):
		var button = buttons[i]

		if button.color_index != solution[i]:
			_fail(i)
			return

	_solve()


func _solve():
	solved = true
	print("PUZZLE RESUELTO")
	
	for button in buttons:
		if button.has_method("show_temp_color"):
			button.show_temp_color(Color.GREEN, 1.0)
			
	for button in buttons:
		button.lock()

	for cube in get_tree().get_nodes_in_group("floating_cubes"):
		cube.activate()
	

func _fail(index: int):
	print("Puzzle incorrecto en botón:", index)
	for button in buttons:
		if button.has_method("show_temp_color"):
			button.show_temp_color(Color.RED, 1.0)
	for button in buttons:
		button.reset()
