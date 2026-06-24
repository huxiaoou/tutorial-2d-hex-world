extends StateAbility

class_name StateAbilityDeactivated

func _ready() -> void:
    current_id = StateAbilityId.DEACTIVATED
    return


func enter() -> void:
    super()
    states_machine_ability.ability.targets.clear()
    await states_machine_ability.ability.ability_activated
    state_changed.emit(StateAbilityId.TARGETING)
    return
