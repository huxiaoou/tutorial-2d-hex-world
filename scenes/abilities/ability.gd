extends Node

class_name Ability

signal ability_activated()
signal ability_deactivated()
signal ability_finished()

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
    for target: UnitTurnBased in targets:
        await target.get_hurt()
    ability_finished.emit()
    return
