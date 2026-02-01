extends Node3D

@export var buttons: Array[Node]
@onready var animacionpedestalpasado=$"../Pedestal_Pasado/PedestalMascaraPasado/AnimationPlayer"
@onready var colisionmascaradelpasado=$"../Pedestal_Pasado/MaskFuturePickUp/CollisionShape3D"
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
	animacionpedestalpasado.play("Animation")
	colisionmascaradelpasado.disabled=false
	print("PUZZLE DE BOTONES RESUELTO")
