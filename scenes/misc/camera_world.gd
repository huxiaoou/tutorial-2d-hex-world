extends Camera2D

class_name CameraWorld

@export_group("Custom")
@export var move_speed: float = 1200
@export var init_pos: Vector2 = Vector2(0, 0)

var lim_left_top: Vector2 = Vector2.ZERO
var lim_right_bottom: Vector2 = Vector2.ZERO


func _ready() -> void:
    position = init_pos
    print("CameraWorld ready")


func set_limits(left_top: Vector2, right_bottom: Vector2) -> void:
    lim_left_top = left_top + get_viewport().size * 0.5
    lim_right_bottom = right_bottom - get_viewport().size * 0.5
    return


func _process(delta: float) -> void:
    var direction: Vector2 = Input.get_vector(
        "camera_move_left",
        "camera_move_right",
        "camera_move_up",
        "camera_move_down",
    )
    position += direction * move_speed * delta
    position.x = clamp(position.x, lim_left_top.x, lim_right_bottom.x)
    position.y = clamp(position.y, lim_left_top.y, lim_right_bottom.y)
    return
