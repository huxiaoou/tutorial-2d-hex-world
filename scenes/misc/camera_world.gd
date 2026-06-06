extends Camera2D

class_name CameraWorld

@export_group("Custom")
@export var move_speed: float = 1000
@export var init_pos: Vector2 = Vector2(1920, 1080) *0.5

func _ready() -> void:
    position = init_pos

func _process(delta: float) -> void:
    var direction: Vector2 = Input.get_vector(
        "camera_move_left",
        "camera_move_right",
        "camera_move_up",
        "camera_move_down",
    )
    position += direction * move_speed * delta
    return
