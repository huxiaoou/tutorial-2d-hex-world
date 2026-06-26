extends Node

class_name Ability

signal ability_activated()
signal ability_deactivated()
signal ability_finished()
signal hurt_batch_finished()

@export var max_target_qty: int = 2
@onready var states_machine_ability: StatesMachineAbility = $StatesMachineAbility

var owner_unit: UnitTurnBased = null
var targets: Array[UnitTurnBased] = []


func _ready() -> void:
    states_machine_ability.setup(self)
    return


func activate() -> void:
    ability_activated.emit()
    return


func deactivate() -> void:
    ability_deactivated.emit()
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
    return true


func remove_target(unit: UnitTurnBased) -> bool:
    if unit in targets:
        targets.erase(unit)
        return true
    return false


func cast_ability() -> void:
    print("Casting ability on targets: ", targets)
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

    for target: UnitTurnBased in targets:
        target.get_hurt()

    if not pending_targets.is_empty():
        await hurt_batch_finished

    for target: UnitTurnBased in targets:
        if is_instance_valid(target) and target.hurt_finished.is_connected(on_hurt_finished):
            target.hurt_finished.disconnect(on_hurt_finished)

    ability_finished.emit()
    return
