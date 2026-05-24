extends CharacterBody3D

@export var speed := 6.0
@export var sprint_speed := 10.0
@export var jump_force := 5.5
@export var gravity := 9.8

var direction = Vector3.ZERO

@onready var camera = $Camera3D

func _physics_process(delta):
    handle_movement(delta)
    handle_gravity(delta)

func handle_movement(delta):
    var input_dir = Vector2(
        Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
        Input.get_action_strength("move_back") - Input.get_action_strength("move_forward")
    )

    direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

    var current_speed = speed
    if Input.is_action_pressed("sprint"):
        current_speed = sprint_speed

    velocity.x = direction.x * current_speed
    velocity.z = direction.z * current_speed

    if Input.is_action_just_pressed("jump") and is_on_floor():
        velocity.y = jump_force

    move_and_slide()

func handle_gravity(delta):
    if not is_on_floor():
        velocity.y -= gravity * delta