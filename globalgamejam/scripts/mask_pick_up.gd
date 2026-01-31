extends Area3D

const MASK_PAST := 0
const MASK_FUTURE := 1
const MASK_OCCULT := 2

@export var mask_type := MASK_FUTURE
@export var mask_manager: Node

var rotate_speed := 1.5


func _process(delta: float) -> void:
	rotate_y(rotate_speed * delta)


func interact(_interactor):
	mask_manager.unlock_mask(mask_type)
	queue_free()
