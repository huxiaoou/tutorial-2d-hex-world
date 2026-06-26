extends StateAbility

class_name StateAbilityTargeting

func _ready() -> void:
    current_id = StateAbilityId.TARGETING
    return


func _on_ability_deactivated() -> void:
    state_changed.emit(StateAbilityId.DEACTIVATED)
    return


func enter() -> void:
    super()
    SignalBus.unit_selected.connect(on_unit_selected)
    SignalBus.unit_deselected.connect(on_unit_deselected)
    sma.ability.ability_deactivated.connect(_on_ability_deactivated)
    sma.ability.init_potential_targets()
    return


func exit() -> void:
    sma.ability.reset_potential_targets()
    SignalBus.unit_selected.disconnect(on_unit_selected)
    SignalBus.unit_deselected.disconnect(on_unit_deselected)
    sma.ability.ability_deactivated.disconnect(_on_ability_deactivated)
    super()
    return


func on_unit_selected(unit: UnitTurnBased) -> void:
    if sma.ability.add_target(unit):
        print("Unit added to targets: ", unit.unit_name)
        print("Current targets: ", sma.ability.targets)
    return


func on_unit_deselected(unit: UnitTurnBased) -> void:
    if sma.ability.remove_target(unit):
        print("Unit removed from targets: ", unit.unit_name)
        print("Current targets: ", sma.ability.targets)
    return


func unhandled_input(event: InputEvent) -> void:
    if event.is_action_pressed("confirm"):
        if sma.ability.targets.size() > 0:
            state_changed.emit(StateAbilityId.CASTING)
        else:
            print("No targets selected. Cannot cast ability.")
    elif event.is_action_pressed("cancel"):
        state_changed.emit(StateAbilityId.DEACTIVATED)
    elif event.is_action_pressed("next_target"):
        sma.ability.select_next_potential_target(1)
    elif event.is_action_pressed("prev_target"):
        sma.ability.select_next_potential_target(-1)
    return
