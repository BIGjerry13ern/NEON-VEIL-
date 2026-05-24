extends CharacterBody3D

@export var speed := 3.5
@export var health := 50

var player = null

func _ready():
    player = get_tree().get_first_node_in_group("player")

func _physics_process(delta):
    if not player:
        return

    var dir = (player.global_transform.origin - global_transform.origin).normalized()
    velocity = dir * speed

    move_and_slide()

func take_damage(amount):
    health -= amount
    if health <= 0:
        queue_free()