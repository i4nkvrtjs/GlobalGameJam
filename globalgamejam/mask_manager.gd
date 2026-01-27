extends Node

enum MaskType {
	NONE,
	PAST,
	FUTURE,
	HIDDEN
}

var current_mask: MaskType = MaskType.NONE


func _input(event):
	if event.is_action_pressed("mask1"):
		toggle_mask(MaskType.PAST)

	elif event.is_action_pressed("mask2"):
		toggle_mask(MaskType.FUTURE)

	elif event.is_action_pressed("mask3"):
		toggle_mask(MaskType.HIDDEN)


# ---------------- TOGGLE ----------------

func toggle_mask(mask: MaskType):
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

	print("Máscara equipada:", mask)


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
	print("Máscara removida")


# ---------------- PAST ----------------

func _activate_past():
	pass


func _deactivate_past():
	pass


# ---------------- FUTURE ----------------

func _activate_future():
	pass


func _deactivate_future():
	pass


# ---------------- HIDDEN ----------------

func _activate_hidden():
	for obj in get_tree().get_nodes_in_group("hidden"):
		if obj.has_method("reveal"):
			obj.reveal()


func _deactivate_hidden():
	for obj in get_tree().get_nodes_in_group("hidden"):
		if obj.has_method("hide"):
			obj.hide()
