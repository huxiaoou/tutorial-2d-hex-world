extends Node2D

class_name PoseEffect

@onready var background: TextureRect = $Background
@onready var ghost_trail: GhostTrail = $TextureRect
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

const HERO_LINE = preload("uid://bdsnlq27p8uk")
const WEAPON_IMPACT = preload("uid://djopi6fe0x5dj")


func _ready() -> void:
    ghost_trail.hide_tex()


func _unhandled_input(event: InputEvent) -> void:
    if event.is_action_pressed("toggle_debug"):
        play_main()
    return


func play_main() -> void:
    animation_player.play("main")
    await animation_player.animation_finished
    return


func play_movement() -> void:
    ghost_trail.play_movement()
    return


func play_lines() -> void:
    audio_stream_player_2d.stream = HERO_LINE
    audio_stream_player_2d.play()


func play_weapon_impact() -> void:
    audio_stream_player_2d.stream = WEAPON_IMPACT
    audio_stream_player_2d.play()


func background_fade_in() -> void:
    var tw: Tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
    tw.tween_property(background, "modulate:a", 0.8, 1.0)
    return


func background_fade_out() -> void:
    var tw: Tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
    tw.tween_property(background, "modulate:a", 0.0, 1.0)
    return
