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
