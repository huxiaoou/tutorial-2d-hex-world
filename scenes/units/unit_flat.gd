class_name UnitFlat
extends CharacterBody2D

@export var max_move_speed: float = 600
@export var accerlate: float = 300
var move_speed: float = 0


func _physics_process(delta: float) -> void:
    var direction: Vector2 = Input.get_vector(
        "camera_move_left",
        "camera_move_right",
        "camera_move_up",
        "camera_move_down",
    )
    if direction != Vector2.ZERO:
        move_speed = move_toward(move_speed, max_move_speed, accerlate * delta)
    else:
        move_speed = move_toward(move_speed, 0, accerlate * delta)
    velocity = direction * move_speed
    move_and_slide()
    return
