extends StaticBody3D

@export var press_depth := 0.05
@export var press_time := 0.2

var pressed := false
var start_position: Vector3


func _ready():
	start_position = global_position


func interact(_interactor):
	if pressed:
		return

	pressed = true
	_press_animation()


func _press_animation():
	var BotonAnimado = get_child(2)
	var AnimaciondelBoton = BotonAnimado.get_child(1)
	AnimaciondelBoton.play("Cube_001Action_001")
