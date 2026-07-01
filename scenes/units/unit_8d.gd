extends CharacterBody2D

class_name Unit8D

@onready var body: AnimatedSprite2D = $body
@onready var shadow: AnimatedSprite2D = $shadow

func _unhandled_input(event: InputEvent) -> void:
    if event.is_action_pressed("toggle_debug"):
        play_attack()

func play_attack() -> void:        
    body.play("attack")
    shadow.play("attack")
    await body.animation_finished
    body.play("idle")
    shadow.play("idle")
    return
