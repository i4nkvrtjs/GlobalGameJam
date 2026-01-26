extends Node3D

@export var open_angle := 90.0
@export var open_speed := 3.0

var is_open := false
var target_rotation := 0.0

func _ready():
	target_rotation = rotation.y

func interact(_player):
	is_open = !is_open

	if is_open:
		target_rotation = deg_to_rad(open_angle)
	else:
		target_rotation = 0.0

func _process(delta):
	rotation.y = lerp(rotation.y, target_rotation, open_speed * delta)
