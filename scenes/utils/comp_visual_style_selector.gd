extends Node

class_name CompVisualStyleSelector

enum VisualStyle {
    NON_PIXEL,
    PIXEL,
}

const VISUAL_STYLE_RESOLUTIONS: Dictionary[VisualStyle, Vector2i] = {
    VisualStyle.NON_PIXEL: Vector2i(1920, 1080),
    VisualStyle.PIXEL: Vector2i(16, 9) * 60,
}

@export_group("Visual Style")
@export var visual_style: VisualStyle = VisualStyle.PIXEL
@export var pixel_resolutions: Vector2i = VISUAL_STYLE_RESOLUTIONS[VisualStyle.PIXEL]
@export var non_pixel_resolutions: Vector2i = VISUAL_STYLE_RESOLUTIONS[VisualStyle.NON_PIXEL]


func _ready() -> void:
    match visual_style:
        VisualStyle.NON_PIXEL:
            set_non_pixel_visual_style()
        VisualStyle.PIXEL:
            set_pixel_visual_style()
    return


func set_pixel_visual_style() -> void:
    var root_window: Window = get_window()
    root_window.content_scale_size = pixel_resolutions
    root_window.content_scale_aspect = Window.CONTENT_SCALE_ASPECT_KEEP
    root_window.content_scale_mode = Window.CONTENT_SCALE_MODE_VIEWPORT
    return


func set_non_pixel_visual_style() -> void:
    var root_window: Window = get_window()
    root_window.content_scale_size = non_pixel_resolutions
    root_window.content_scale_aspect = Window.CONTENT_SCALE_ASPECT_KEEP
    root_window.content_scale_mode = Window.CONTENT_SCALE_MODE_VIEWPORT
    return
