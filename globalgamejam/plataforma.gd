extends Node3D

@export var platform_color: Color = Color.RED
@export var output_color: Color = Color.BLUE

@onready var area: Area3D = $Area3D
@onready var mesh: MeshInstance3D = $MeshInstance3D

func _ready():
	_set_platform_color()
	area.body_entered.connect(_on_body_entered)

func _set_platform_color():
	var mat := StandardMaterial3D.new()
	mat.albedo_color = platform_color
	mesh.material_override = mat

func _on_body_entered(body):
	if body.has_method("try_change_color"):
		body.try_change_color(platform_color, output_color)
