extends Node3D

@export var visible_by_default := false

func _ready():
	_set_visible(visible_by_default)


func reveal():
	_set_visible(true)


func _hide():
	_set_visible(false)


func _set_visible(value: bool):
	visible = value

	if has_node("CollisionShape3D"):
		$CollisionShape3D.disabled = not value
