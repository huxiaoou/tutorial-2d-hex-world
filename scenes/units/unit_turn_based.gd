@tool
extends CharacterBody2D

class_name UnitTurnBased

@export var tex_character: Texture2D
@export var unit_name: String = "Unknown Unit"
@export var initiative: int = 10
@export var is_player: bool = true

signal turn_finished()

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D


static func is_quicker(a: UnitTurnBased, b: UnitTurnBased) -> bool:
    return a.initiative > b.initiative


func _ready() -> void:
    sprite_2d.texture = tex_character
    sprite_2d.offset.y = -sprite_2d.texture.get_height() / 2.0
    collision_shape_2d.position.y = -sprite_2d.texture.get_height() / 2.0

    var adj_scale: float = clamp(position.y / 1000.0, 0.2, 1.0)
    scale = Vector2.ONE * 0.8 * adj_scale

    add_to_group("units")


func ai_take_action() -> void:
    if is_player:
        return
    print("AI taking action for unit: ", unit_name)
    await get_tree().create_timer(1.0).timeout
    end_turn()
    return


func _unhandled_input(event: InputEvent) -> void:
    if event.is_action_pressed("player_ends_turn") and is_player:
        print("Player ends turn for unit: ", unit_name)
        end_turn()
    return


func end_turn() -> void:
    turn_finished.emit()
    return
