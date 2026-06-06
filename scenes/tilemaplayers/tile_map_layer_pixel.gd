extends TileMapLayer

class_name Pixel32TileMapLayer

func _ready() -> void:
    var root_window: Window = get_window()
    root_window.content_scale_size = Vector2i(640, 360)
    root_window.content_scale_aspect = Window.CONTENT_SCALE_ASPECT_KEEP
    root_window.content_scale_mode = Window.CONTENT_SCALE_MODE_VIEWPORT
