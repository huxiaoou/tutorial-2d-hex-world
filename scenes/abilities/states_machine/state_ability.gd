extends Node

class_name StateAbility

enum StateAbilityId {
    DEACTIVATED,
    TARGETING,
    CASTING,
}

var state_ability_names: Dictionary[StateAbilityId, String] = {
    StateAbilityId.DEACTIVATED: "Deactivated",
    StateAbilityId.TARGETING: "Targeting",
    StateAbilityId.CASTING: "Casting",
}

var states_machine_ability: StatesMachineAbility
var current_id: StateAbilityId

signal state_changed(new_state: StateAbilityId)


func enter() -> void:
    print("Entering state: ", state_ability_names[current_id])


func exit() -> void:
    print("Exit state: ", state_ability_names[current_id])


func process(_delta: float) -> void:
    pass


func physics_process(_delta: float) -> void:
    pass
