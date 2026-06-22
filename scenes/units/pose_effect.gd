extends Node2D

class_name PoseEffect

@onready var texture_rect: TextureRect = $TextureRect
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

const HERO_LINE = preload("uid://bdsnlq27p8uk")
const WEAPON_IMPACT = preload("uid://djopi6fe0x5dj")
const MOVE_IN_DURATION: float = 1.0
const MOVE_OUT_DURATION: float = 1.0
const MOVE_BACK_DURATION: float = 0.8
const MOVE_BACK_OFFSET: float = -200.0
const DISPLAY_DURATION: float = 0.05


func _ready() -> void:
    hide_tex()


func _unhandled_input(event: InputEvent) -> void:
    if event.is_action_pressed("toggle_debug"):
        animation_player.play("main")


func hide_tex() -> void:
    texture_rect.position.x = -texture_rect.size.x
    texture_rect.visible = false
    return


func play_movement() -> void:
    texture_rect.visible = true

    var tween = create_tween()
    var center_x = get_viewport_rect().size.x / 2.0 - texture_rect.size.x / 2.0
    var right_x = get_viewport_rect().size.x

    tween.tween_property(texture_rect, "position:x", center_x, MOVE_IN_DURATION) \
            .set_trans(Tween.TRANS_CUBIC) \
            .set_ease(Tween.EASE_OUT)
    tween.tween_property(texture_rect, "position:x", center_x + MOVE_BACK_OFFSET, MOVE_BACK_DURATION) \
            .set_trans(Tween.TRANS_CUBIC) \
            .set_ease(Tween.EASE_OUT)
    tween.tween_property(texture_rect, "position:x", right_x, MOVE_OUT_DURATION) \
            .set_trans(Tween.TRANS_CUBIC) \
            .set_ease(Tween.EASE_IN)

    await tween.finished
    hide_tex()
    return


func play_lines() -> void:
    audio_stream_player_2d.stream = HERO_LINE
    audio_stream_player_2d.play()


func play_weapon_impact() -> void:
    audio_stream_player_2d.stream = WEAPON_IMPACT
    audio_stream_player_2d.play()
