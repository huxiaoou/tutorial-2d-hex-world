extends Node2D

class_name LevelDungeon

#@onready var camera_world: CameraWorld = $CameraWorld
@onready var sprite_2d: Sprite2D = $Sprite2D


func _ready() -> void:
    #var map_size: Vector2i = sprite_2d.texture.get_size()
    #camera_world.set_limits(-map_size * 0.5, map_size * 0.5)
    print("LevelDungeon ready")
