@tool
extends CharacterBody2D

class_name UnitTurnBased

@export var tex_character: Texture2D
@export var unit_name: String = "Unknown Unit"
@export var initiative: int = 10
@export var is_player: bool = true
@export var is_current: bool = false

var is_focused_target: bool = false
var is_selected: bool:
    set(value):
        is_selected = value
        target_icon.visible = value

signal turn_finished()
signal unit_selected(unit: UnitTurnBased)
signal unit_deselected(unit: UnitTurnBased)
signal hurt_finished(unit: UnitTurnBased)

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var target_icon: Sprite2D = $TargetIcon
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var ability_attack: Ability = $Abilities/AbilityAttack
@onready var animation_player: AnimationPlayer = $AnimationPlayer

const CURRENT_MODULATE: Color = Color(1.0, 1.0, 1.0, 1.0)
const NOT_CURRENT_MODULATE: Color = Color(0.5, 0.5, 0.5, 1.0)


static func is_quicker(a: UnitTurnBased, b: UnitTurnBased) -> bool:
    return a.initiative > b.initiative


func _ready() -> void:
    sprite_2d.texture = tex_character
    sprite_2d.offset.y = -sprite_2d.texture.get_height() / 2.0
    collision_shape_2d.position.y = -sprite_2d.texture.get_height() / 2.0
    target_icon.position.y = -sprite_2d.texture.get_height() - target_icon.texture.get_height() / 2.0 * 0.2 - 60

    var adj_scale: float = clamp(position.y / 1000.0, 0.2, 1.0)
    scale = Vector2.ONE * 0.6 * adj_scale

    set_current(is_current)
    add_to_group("units")
    if is_player:
        add_to_group("players")
    else:
        add_to_group("enemies")

    if not Engine.is_editor_hint():
        ability_attack.owner_unit = self
        unit_selected.connect(SignalBus.on_unit_selected)
        unit_deselected.connect(SignalBus.on_unit_deselected)
    return


func toggle_focused(focused: bool) -> void:
    is_focused_target = focused
    sprite_2d.material.set_shader_parameter("focused", focused)
    return


func tween_to_target_module(target_modulate: Color) -> void:
    var tween: Tween = create_tween()
    tween.set_trans(Tween.TransitionType.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
    tween.tween_property(sprite_2d, "modulate", target_modulate, 0.5)
    return


func set_current(_is_current: bool) -> void:
    is_current = _is_current
    if is_current:
        tween_to_target_module(CURRENT_MODULATE)
    else:
        tween_to_target_module(NOT_CURRENT_MODULATE)
    return


func ai_take_action() -> void:
    if is_player:
        return
    print("AI taking action for unit: ", unit_name)
    await get_tree().create_timer(3.0).timeout
    end_turn()
    return


func end_turn() -> void:
    turn_finished.emit()
    return


func _unhandled_input(event: InputEvent) -> void:
    if event.is_action_pressed("selected"):
        if is_focused_target:
            if not is_selected:
                unit_selected.emit(self)
            else:
                unit_deselected.emit(self)
        return
    if not is_current or not is_player:
        return
    if event.is_action_pressed("player_ends_turn"):
        print("Player ends turn for unit: ", unit_name)
        end_turn()
    return


func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
    if event.is_action_pressed("interact"):
        unit_selected.emit(self)
        get_viewport().set_input_as_handled()
    elif event.is_action_pressed("de-interact"):
        unit_deselected.emit(self)
        get_viewport().set_input_as_handled()
    return


func get_hurt() -> void:
    is_selected = false
    animation_player.play("hurt")
    await animation_player.animation_finished
    animation_player.play("battle_ready")
    hurt_finished.emit(self)
    return
