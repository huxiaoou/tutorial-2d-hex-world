extends StateAbility

class_name StateAbilityDeactivated

func _ready() -> void:
    current_id = StateAbilityId.DEACTIVATED
    return


func enter() -> void:
    super()
    sma.ability.targets.clear()
    sma.ability.ability_activated.connect(_on_ability_activated)
    return


func _on_ability_activated() -> void:
    state_changed.emit(StateAbilityId.TARGETING)
    return


func exit() -> void:
    sma.ability.ability_activated.disconnect(_on_ability_activated)
    super()
    return
