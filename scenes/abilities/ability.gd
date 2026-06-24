extends Node

class_name Ability

signal ability_activated()

@export var max_target_qty: int = 1
@onready var states_machine_ability: StatesMachineAbility = $StatesMachineAbility

var owner_unit: UnitTurnBased = null
var targets: Array[UnitTurnBased] = []


func _ready() -> void:
    states_machine_ability.setup(self)
    return


func activate() -> void:
    ability_activated.emit()
    return


func _unhandled_input(event: InputEvent) -> void:
    if owner_unit == null:
        return
    if not owner_unit.is_player:
        return
    if not owner_unit.is_current:
        return
    if event.is_action_pressed("ability_1"):
        activate()
    return
