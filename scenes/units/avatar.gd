@tool
class_name Avatar
extends CharacterBody2D

@export var tiling_offset: Vector2 = Vector2(0.35, 0)
@export var tiling_scale: float = 0.6
@export var tex: Texture2D
@export var max_move_speed: float = 600
@export var accerlate: float = 300
@export var bg_modulate: Color = Color(0.09,0, 0, 0.8)

var move_speed: float = 0

@onready var texture_rect: TextureRect = $Control/TextureRect
@onready var bg: TextureRect = $Control/Bg


func _ready() -> void:
    set_avatar()


func set_avatar() -> void:
    bg.modulate = bg_modulate
    texture_rect.texture = tex
    if texture_rect.material is ShaderMaterial:
        texture_rect.material.set_shader_parameter("tiling_offset", tiling_offset)
        texture_rect.material.set_shader_parameter("tiling_scale", tiling_scale)


func _physics_process(delta: float) -> void:
    if Engine.is_editor_hint():
        return

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
