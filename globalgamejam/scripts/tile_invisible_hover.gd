extends Node3D

@onready var mesh: MeshInstance3D = $StaticBody3D/MeshInstance3D
@onready var area: Area3D = $Area3D


func _ready():
	mesh.visible = false

func _on_area_body_entered(body):
	if body is CharacterBody3D:
		mesh.visible = true

func _on_area_body_exited(body):
	if body is CharacterBody3D:
		mesh.visible = false
