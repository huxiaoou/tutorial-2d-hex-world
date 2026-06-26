extends StateAbility

class_name StateAbilityCasting

func _ready() -> void:
    current_id = StateAbilityId.CASTING
    return


func _on_ability_finished() -> void:
    state_changed.emit(StateAbilityId.DEACTIVATED)
    return


func enter() -> void:
    super()
    sma.ability.ability_finished.connect(_on_ability_finished)
    sma.ability.cast_ability()
    return


func exit() -> void:
    sma.ability.ability_finished.disconnect(_on_ability_finished)
    super()
    return
