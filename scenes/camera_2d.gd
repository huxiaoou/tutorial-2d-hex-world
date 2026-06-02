extends Camera2D

class_name CameraWorld

@export var move_speed: float = 1000


func _process(delta: float) -> void:
    var direction: Vector2 = Input.get_vector(
        "camera_move_left",
        "camera_move_right",
        "camera_move_up",
        "camera_move_down",
    )
    position += direction * move_speed * delta
    return
