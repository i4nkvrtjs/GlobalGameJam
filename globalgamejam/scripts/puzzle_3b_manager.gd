extends Node

@export var buttons: Array[NodePath]
@export var check_button: NodePath

const GREEN := 1
const YELLOW := 2
const ORANGE := 3

var phase := 0
var future_mask_unlocked := false


func unlock_future_mask():
	future_mask_unlocked = true
	phase = 1
	print("Puzzle futuro ACTIVADO → FASE VERDE")


func on_check_pressed():
	if not future_mask_unlocked:
		return

	match phase:
		1:
			if _all_buttons_match(GREEN):
				_reset_buttons()
				phase = 2
				print("FASE AMARILLA")
		2:
			if _all_buttons_match(YELLOW):
				_reset_buttons()
				phase = 3
				print("FASE NARANJA")
		3:
			if _all_buttons_match(ORANGE):
				_solve_puzzle()


func _all_buttons_match(expected_index: int) -> bool:
	for path in buttons:
		var btn = get_node(path)
		if btn.get_color_index() != expected_index:
			return false
	return true


func _reset_buttons():
	for path in buttons:
		get_node(path).reset()


func _solve_puzzle():
	phase = 4
	print("PUZZLE RESUELTO")
