extends Node3D

@export var float_height := 4.0
@export var float_time := 7.0

var start_pos : Vector3

func _ready():
	start_pos = global_position
	add_to_group("floating_cubes")

func activate():
	print("Cubo flotando:", name)

	var tween := create_tween()
	tween.tween_property(
		self,
		"global_position",
		start_pos + Vector3.UP * float_height,
		float_time
	)
