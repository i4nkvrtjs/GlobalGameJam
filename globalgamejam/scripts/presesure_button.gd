extends StaticBody3D

@export var press_depth := 0.05
@export var press_time := 0.2
@onready var animationbutton = $"../Pedestal_Boton_Futuro/AnimationPlayer"

var pressed := false
var start_position: Vector3


func _ready():
	start_position = global_position


func interact(_interactor):
	if pressed:
		return

	pressed = true
	animationbutton.play("Cube_001Action")
	_press_animation()


func _press_animation():
	var tween = create_tween()
	tween.tween_property(
		self,
		"global_position",
		start_position - Vector3.DOWN * press_depth,
		press_time
	)
	
