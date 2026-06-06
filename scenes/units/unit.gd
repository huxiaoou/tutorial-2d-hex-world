extends CharacterBody2D

class_name Unit

@onready var sprite_2d: Sprite2D = $Sprite2D

var origin_y_scale: float = 1.0


func _ready() -> void:
    origin_y_scale = scale.y


func _process(delta: float) -> void:
    scale.y = origin_y_scale * (1 + 0.005 * sin(0.2 * Time.get_ticks_msec() * delta))
