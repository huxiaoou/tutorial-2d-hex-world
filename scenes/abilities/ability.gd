extends Node

class_name Ability

signal ability_activated()
signal ability_deactivated()
signal ability_finished()
signal hurt_batch_finished()

@export var max_target_qty: int = 2
@export var scene_effect: PackedScene = preload("res://scenes/units/pose_effect.tscn")
@onready var states_machine_ability: StatesMachineAbility = $StatesMachineAbility

var owner_unit: UnitTurnBased = null
var targets: Array[UnitTurnBased] = []
var potential_targets: Array[UnitTurnBased] = []
var potential_target: UnitTurnBased = null
var pos_effect: PoseEffect = null


func _ready() -> void:
    states_machine_ability.setup(self)
    pos_effect = scene_effect.instantiate()
    add_child(pos_effect)
    return


func activate() -> void:
    ability_activated.emit()
    return


func deactivate() -> void:
    ability_deactivated.emit()
    return


func init_potential_targets() -> void:
    var nodes: Array[Node] = []
    if owner_unit.is_player:
        nodes = get_tree().get_nodes_in_group("enemies")
    else:
        nodes = get_tree().get_nodes_in_group("players")

    potential_targets.clear()
    for node in nodes:
        potential_targets.append(node as UnitTurnBased)
    if not potential_targets.is_empty():
        potential_target = potential_targets[0]
        potential_target.toggle_focused(true)
    return


func select_next_potential_target(next: int = 1) -> void:
    if potential_targets.size() <= 1:
        return
    if potential_target:
        potential_target.toggle_focused(false)
    var current_index: int = potential_targets.find(potential_target)
    var next_index: int = (current_index + next) % potential_targets.size()
    potential_target = potential_targets[next_index]
    potential_target.toggle_focused(true)
    return


func reset_potential_targets() -> void:
    if potential_target:
        potential_target.toggle_focused(false)
    potential_targets.clear()
    return


func _unhandled_input(event: InputEvent) -> void:
    if owner_unit == null:
        return
    if not owner_unit.is_player:
        return
    if not owner_unit.is_current:
        return
    if event.is_action_pressed("ability_1"):
        if states_machine_ability.is_deactivated():
            activate()
        elif states_machine_ability.is_targeting():
            deactivate()
    return


func add_target(unit: UnitTurnBased) -> bool:
    if unit in targets:
        return false
    if targets.size() >= max_target_qty:
        return false
    targets.append(unit)
    unit.is_selected = true
    return true


func remove_target(unit: UnitTurnBased) -> bool:
    if unit in targets:
        targets.erase(unit)
        unit.is_selected = false
        return true
    return false


func get_target_pos() -> Vector2:
    var min_x: float = INF
    var max_x: float = -INF
    for target in targets:
        min_x = min(min_x, target.position.x)
        max_x = max(max_x, target.position.x)
    if owner_unit.position.x < min_x and min_x < INF:
        return owner_unit.position + Vector2((min_x - owner_unit.position.x) * 0.3, 0)
    if owner_unit.position.x > max_x and max_x > -INF:
        return owner_unit.position + Vector2((max_x - owner_unit.position.x) * 0.3, 0)
    return owner_unit.position


func cast_ability() -> void:
    print("Casting ability on targets: ", targets)
    await owner_unit.move_to_target_position(get_target_pos())

    if targets.is_empty():
        ability_finished.emit()
        return

    var pending_targets: Array[UnitTurnBased] = targets.duplicate()
    var on_hurt_finished: Callable = func(unit: UnitTurnBased) -> void:
        if unit in pending_targets:
            pending_targets.erase(unit)
            if pending_targets.is_empty():
                hurt_batch_finished.emit()

    for target: UnitTurnBased in targets:
        if not target.hurt_finished.is_connected(on_hurt_finished):
            target.hurt_finished.connect(on_hurt_finished)

    await pos_effect.play_main()

    for target: UnitTurnBased in targets:
        target.get_hurt()

    if not pending_targets.is_empty():
        await hurt_batch_finished

    for target: UnitTurnBased in targets:
        if is_instance_valid(target) and target.hurt_finished.is_connected(on_hurt_finished):
            target.hurt_finished.disconnect(on_hurt_finished)

    await owner_unit.move_to_original_position()

    ability_finished.emit()
    return
