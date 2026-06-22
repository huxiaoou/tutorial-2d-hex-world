extends Node2D

class_name PoseEffect

@onready var ghost_trail: GhostTrail = $TextureRect
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

const HERO_LINE = preload("uid://bdsnlq27p8uk")
const WEAPON_IMPACT = preload("uid://djopi6fe0x5dj")


func _ready() -> void:
    ghost_trail.hide_tex()


func _unhandled_input(event: InputEvent) -> void:
    if event.is_action_pressed("toggle_debug"):
        animation_player.play("main")


func play_movement() -> void:
    ghost_trail.play_movement()
    return


func play_lines() -> void:
    audio_stream_player_2d.stream = HERO_LINE
    audio_stream_player_2d.play()


func play_weapon_impact() -> void:
    audio_stream_player_2d.stream = WEAPON_IMPACT
    audio_stream_player_2d.play()
