extends Node3D

@export var damage := 10
@export var fire_rate := 0.15
@export var range := 100.0

var can_shoot := true

func shoot(origin, direction):
    if not can_shoot:
        return

    can_shoot = false

    var space = get_world_3d().direct_space_state
    var query = PhysicsRayQueryParameters3D.create(origin, origin + direction * range)

    var result = space.intersect_ray(query)

    if result:
        if result.collider.has_method("take_damage"):
            result.collider.take_damage(damage)

    await get_tree().create_timer(fire_rate).timeout
    can_shoot = true