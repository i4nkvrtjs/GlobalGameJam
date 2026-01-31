extends Node

@onready var color_rect: ColorRect = $"../FiltroOculto/ColorRect"

enum MaskType {
	NONE,
	PAST,
	FUTURE,
	HIDDEN
}

var unlocked_masks := {
	MaskType.HIDDEN: false,
	MaskType.PAST: false,
	MaskType.FUTURE: false
}

var current_mask: MaskType = MaskType.NONE
var future_puzzle_unlocked := false

@export var normal_puzzle: Node3D
@export var hidden_puzzle: Node3D
@export var future_puzzle: Node

func _ready():
	_clear_mask()

func _input(event):
	if event.is_action_pressed("mask1"):
		toggle_mask(MaskType.PAST)
	elif event.is_action_pressed("mask2"):
		toggle_mask(MaskType.FUTURE)
	elif event.is_action_pressed("mask3"):
		toggle_mask(MaskType.HIDDEN)


# ---------------- UNLOCK ----------------

func unlock_mask(mask: MaskType):
	unlocked_masks[mask] = true
	print("Máscara desbloqueada:", mask)

	if mask == MaskType.FUTURE:
		_unlock_future_puzzle()

# ---------------- TOGGLE ----------------

func toggle_mask(mask: MaskType):
	if not unlocked_masks.get(mask, false):
		return

	if current_mask == mask:
		_clear_mask()
	else:
		_set_mask(mask)


# ---------------- SET / CLEAR ----------------

func _set_mask(mask: MaskType):
	_clear_mask()
	current_mask = mask

	match mask:
		MaskType.PAST:
			_activate_past()
		MaskType.FUTURE:
			_activate_future()
		MaskType.HIDDEN:
			_activate_hidden()


func _clear_mask():
	if current_mask == MaskType.NONE:
		return

	match current_mask:
		MaskType.PAST:
			_deactivate_past()
		MaskType.FUTURE:
			_deactivate_future()
		MaskType.HIDDEN:
			_deactivate_hidden()

	current_mask = MaskType.NONE


# ---------------- PAST ----------------

func _activate_past():
	print("Máscara del pasado activada")

func _deactivate_past():
	print("Máscara del pasado desactivada")


# ---------------- FUTURE ----------------

func _activate_future():
	pass

func _deactivate_future():
	pass

func _unlock_future_puzzle():
	future_puzzle_unlocked = true

	if future_puzzle:
		set_puzzle_enabled(future_puzzle, true)
		if future_puzzle.has_method("unlock_future_mask"):
			future_puzzle.unlock_future_mask()
			
	print("Puzzle del futuro desbloqueado")

# ---------------- HIDDEN ----------------

func _activate_hidden():
	print("Máscara de lo oculto activada")
	
	for obj in get_tree().get_nodes_in_group("hidden"):
		if not is_instance_valid(obj):
			continue
		if obj.has_method("reveal"):
			obj.reveal()

	hidden_puzzle.visible = true
	normal_puzzle.visible = false

	set_puzzle_enabled(hidden_puzzle, true)
	set_puzzle_enabled(normal_puzzle, false)

	if color_rect:
		color_rect.visible = true


func _deactivate_hidden():
	print("Máscara de lo oculto desactivada")
	
	for obj in get_tree().get_nodes_in_group("hidden"):
		if not is_instance_valid(obj):
			continue
		if obj.has_method("hide"):
			obj.hide()

	hidden_puzzle.visible = false
	normal_puzzle.visible = true

	set_puzzle_enabled(hidden_puzzle, false)
	set_puzzle_enabled(normal_puzzle, true)

	if color_rect:
		color_rect.visible = false


# ---------------- UTIL ----------------

func set_puzzle_enabled(puzzle: Node, enabled: bool):
	if not puzzle:
		return

	puzzle.process_mode = Node.PROCESS_MODE_INHERIT

	for body in puzzle.get_children():
		if body is CollisionObject3D:
			for child in body.get_children():
				if child is CollisionShape3D:
					child.disabled = not enabled
