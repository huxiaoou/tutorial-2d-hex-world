extends TurnState

class_name TurnStateEnemyTurn

func _ready() -> void:
    current_id = TurnStateId.ENEMY_TURN
    return


func enter() -> void:
    super()
    print("Enemy turn for unit: ", turn_states_machine.current_unit.unit_name)
    turn_states_machine.current_unit.set_current(true)
    turn_states_machine.current_unit.ai_take_action()
    await turn_states_machine.current_unit.turn_finished
    state_changed.emit(TurnStateId.NEXT_TURN)
    return


func exit() -> void:
    turn_states_machine.current_unit.set_current(false)
    super()
    return
