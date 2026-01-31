extends CharacterBody3D

@onready var interact_label: Label = $CanvasLayer/InteractLabel
@onready var head: Node3D = $Head
@onready var camera: Camera3D = $Head/Camera3D
@onready var raycast: RayCast3D = $Head/Camera3D/RayCast3D
@onready var dot: ColorRect = $CanvasLayer/Control/ColorRect
@onready var spyglass_reticle: TextureRect = $CanvasLayer/TextureRect

@export var normal_fov := 75.0
@export var spyglass_fov := 25.0
@export var speed := 3.0
@export var mouse_sensitivity := 0.0022
@export var spyglass_sensitivity := 0.0012
@export var gravity := 9.8
@export var interact_distance := 1.5
@export var respawn_marker: Marker3D

var using_spyglass := false
var held_object: Node3D = null
var hold_distance := 0.5
var respawn_position: Vector3


func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	raycast.target_position = Vector3(0, 0, -interact_distance)
	respawn_position = respawn_marker.global_position
	spyglass_reticle.visible = false


func _unhandled_input(event):
	if event is InputEventMouseMotion:
		var sens = spyglass_sensitivity if using_spyglass else mouse_sensitivity
		rotate_y(-event.relative.x * sens)
		head.rotate_x(-event.relative.y * sens)
		head.rotation.x = clamp(
			head.rotation.x,
			deg_to_rad(-80),
			deg_to_rad(80)
		)

	if event.is_action_pressed("interact"):
		_handle_interact()

	if event.is_action_pressed("spyglass"):
		toggle_spyglass()


func _process(_delta):
	if raycast.is_colliding():
		var collider = raycast.get_collider()
		if collider == null:
			dot.color = Color.WHITE
			return

		var distance = raycast.global_transform.origin.distance_to(
			raycast.get_collision_point()
		)

		if distance <= interact_distance and collider.has_method("interact"):
			dot.color = Color.GREEN
			return

	dot.color = Color.WHITE


func _physics_process(delta):
	# --- MODO CATALEJO ---
	if using_spyglass:
		velocity = Vector3.ZERO
		move_and_slide()

		if held_object:
			_update_held_object()

		_update_interact_ui()
		return

	# --- GRAVEDAD ---
	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
		velocity.y = 0

	# --- MOVIMIENTO ---
	var input_dir = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_back") - Input.get_action_strength("move_forward")
	)

	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed

	move_and_slide()

	if held_object:
		_update_held_object()

	_update_interact_ui()


# ---------------- UI ----------------

func _update_interact_ui():
	if using_spyglass:
		interact_label.visible = false
		return

	if held_object:
		interact_label.visible = false
		return

	if raycast.is_colliding():
		var collider = raycast.get_collider()
		if collider == null:
			interact_label.visible = false
			return

		var distance = raycast.global_transform.origin.distance_to(
			raycast.get_collision_point()
		)

		if distance <= interact_distance and collider.has_method("interact"):
			interact_label.visible = true
			return

	interact_label.visible = false


# ---------------- INTERACT ----------------

func _handle_interact():
	if using_spyglass:
		return

	if held_object:
		_drop_object()
		return

	if raycast.is_colliding():
		var collider = raycast.get_collider()
		if collider == null:
			return

		var distance = raycast.global_transform.origin.distance_to(
			raycast.get_collision_point()
		)

		if distance <= interact_distance and collider.has_method("interact"):
			collider.interact(self)


# ---------------- GRAB / DROP ----------------

func grab_object(obj: Node3D):
	held_object = obj
	if obj is RigidBody3D:
		obj.freeze = true


func _drop_object():
	if held_object is RigidBody3D:
		held_object.freeze = false
	held_object = null


func _update_held_object():
	var target_pos = camera.global_transform.origin \
		+ -camera.global_transform.basis.z * hold_distance

	held_object.global_transform.origin = \
		held_object.global_transform.origin.lerp(target_pos, 0.2)


# ---------------- RESPAWN ----------------

func respawn():
	global_position = respawn_position
	velocity = Vector3.ZERO


# ---------------- CATALEJO ----------------

func toggle_spyglass():
	using_spyglass = !using_spyglass

	if using_spyglass:
		_enter_spyglass()
	else:
		_exit_spyglass()


func _enter_spyglass():
	camera.fov = spyglass_fov
	spyglass_reticle.visible = true
	dot.visible = false


func _exit_spyglass():
	camera.fov = normal_fov
	spyglass_reticle.visible = false
	dot.visible = true
