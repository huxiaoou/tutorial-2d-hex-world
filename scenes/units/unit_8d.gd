extends CharacterBody2D

class_name Unit8D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _unhandled_input(event: InputEvent) -> void:
    if event.is_action_pressed("toggle_debug"):
        play_attack()

func play_attack() -> void:        
    animation_player.play("attack")
    await animation_player.animation_finished
    animation_player.play("idle")
    return
