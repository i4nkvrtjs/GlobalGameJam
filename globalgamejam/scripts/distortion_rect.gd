extends ColorRect

@export var duration := 0.4
@export var max_strength := 0.025

var mat: ShaderMaterial

func _ready():
	mat = material
	mat.set_shader_parameter("strength", 0.0)
	visible = false

func play():
	visible = true

	var tween := get_tree().create_tween()
	tween.tween_method(
		func(v): mat.set_shader_parameter("strength", v),
		0.0,
		max_strength,
		duration * 0.5
	)
	tween.tween_method(
		func(v): mat.set_shader_parameter("strength", v),
		max_strength,
		0.0,
		duration * 0.5
	)

	tween.finished.connect(func():
		visible = false
	)
