extends RigidBody3D

@export var current_color: Color = Color.RED

@onready var mesh: MeshInstance3D = $MeshInstance3D

func _ready():
	_apply_color()

func interact(player):
	player.grab_object(self)

func try_change_color(required_color: Color, new_color: Color):
	if current_color == required_color:
		current_color = new_color
		_apply_color()

func _apply_color():
	var mat := StandardMaterial3D.new()
	mat.albedo_color = current_color
	mesh.material_override = mat
