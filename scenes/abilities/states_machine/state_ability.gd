extends Node

class_name StateAbility

enum StateAbilityId {
    DEACTIVATED,
    TARGETING,
    CASTING,
}

var sma: StatesMachineAbility
var current_id: StateAbilityId

signal state_changed(new_state: StateAbilityId)


func enter() -> void:
    print("Entering state: ", StateAbilityId.keys()[current_id])


func exit() -> void:
    print("Exit state: ", StateAbilityId.keys()[current_id])


func process(_delta: float) -> void:
    pass


func physics_process(_delta: float) -> void:
    pass


func unhandled_input(_event: InputEvent) -> void:
    pass
