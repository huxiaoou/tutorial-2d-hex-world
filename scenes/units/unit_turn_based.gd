@tool
extends CharacterBody2D

class_name UnitTurnBased

@export var tex_character: Texture2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D


func _ready() -> void:
    sprite_2d.texture = tex_character
    sprite_2d.offset.y = -sprite_2d.texture.get_height() / 2.0
    collision_shape_2d.position.y = -sprite_2d.texture.get_height() / 2.0

    var adj_scale: float = clamp(position.y / 1000.0, 0.2, 1.0)
    scale = Vector2.ONE * 0.8 * adj_scale

    add_to_group("units")

    #func _process(_delta: float) -> void:
    #sprite_2d.scale.y = 1 + 0.02 * sin(0.005 * Time.get_ticks_msec())
