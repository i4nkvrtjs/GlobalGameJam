extends Node3D

@export var buttons: Array[Node]

@export var solution: Array[Color] = [
	Color.GREEN,
	Color.GREEN,
	Color.ORANGE,
	Color.ORANGE,
	Color.GREEN,
	Color.GREEN,
	Color.YELLOW,
	Color.YELLOW,
	Color.ORANGE,
	Color.ORANGE,
	Color.YELLOW,
	Color.YELLOW
]

@export var auto_resolve := true

var solved := false


func _ready():
	print("Buttons: ", buttons.size())
	print("Solution: ", solution.size())

func check_solution():
	if solved:
		return

	for i in buttons.size():
		var button = buttons[i]

		if button.current_color != solution[i]:
			_fail(i)
			return

	_solve()


func _solve():
	solved = true
	print("✅ PUZZLE RESUELTO")

	if auto_resolve:
		for b in buttons:
			if b.has_method("lock"):
				b.lock()

	# Acá podés:
	# - abrir una puerta
	# - activar plataforma
	# - reproducir sonido
	# - emitir señal


func _fail(index: int):
	print("❌ Puzzle incorrecto en botón:", index)
	# feedback visual / sonido si querés
