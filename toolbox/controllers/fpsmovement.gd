extends CharacterBody3D


@export var speed = 8.0
@export var accel = 16.0
@export var jump = 8.0
@export var sensitivity = 0.2
@export var min_angle = -80
@export var max_angle = 90

@onready var head = $Head
@onready var collision_shape = $CollisionShape3D

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var look_rot : Vector2
var stand_height : float


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _physics_process(delta):
	var move_speed = speed
	
	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
		if Input.is_action_just_pressed("jump"):
			velocity.y = jump

	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = lerp(velocity.x, direction.x * move_speed, accel * delta)
		velocity.z = lerp(velocity.z, direction.z * move_speed, accel * delta)
	else:
		velocity.x = lerp(velocity.x, 0.0, accel * delta)
		velocity.z = lerp(velocity.z, 0.0, accel * delta)

	move_and_slide()
	
	var plat_rot = get_platform_angular_velocity()
	look_rot.y += rad_to_deg(plat_rot.y * delta)
	head.rotation_degrees.x = look_rot.x
	rotation_degrees.y = look_rot.y


func _input(event):
	if event is InputEventMouseMotion:
		look_rot.y -= (event.relative.x * sensitivity)
		look_rot.x -= (event.relative.y * sensitivity)
		look_rot.x = clamp(look_rot.x, min_angle, max_angle)
