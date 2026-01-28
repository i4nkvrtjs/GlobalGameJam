extends Node3D

@export var columns := 12

var correct_sequence := [1, 9, 5, 1]
var pressed_tiles: Array[int] = []

func _ready():
	for tile in get_children():
		if tile.has_signal("tile_pressed"):
			tile.connect("tile_pressed", Callable(self, "_on_tile_pressed"))

func _on_tile_pressed(tile_index: int):
	if pressed_tiles.size() >= 4:
		return

	pressed_tiles.append(tile_index)

	if pressed_tiles.size() == 4:
		_evaluate()

func _evaluate():
	for i in range(4):
		var tile_index := pressed_tiles[i]
		var row := tile_index / columns
		var column := (tile_index % columns) + 1

		if row != i:
			_fail()
			return

		if column != correct_sequence[i]:
			_fail()
			return

	_success()

func _fail():
	print("Puzzle incorrecto")
	pressed_tiles.clear()
	_reset_tiles()

func _success():
	print("PUZZLE RESUELTO")
	for cube in get_tree().get_nodes_in_group("floating_cubes"):
		print("Activando cubo:", cube.name)
		cube.activate()
		
func _reset_tiles():
	for tile in get_children():
		if tile.has_method("reset"):
			tile.reset()
