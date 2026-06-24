extends TurnState

class_name TurnStatePlayerTurn

func _ready() -> void:
    current_id = TurnStateId.PLAYER_TURN
    return


func enter() -> void:
    super()
    print("Player turn for unit: ", turn_states_machine.current_unit.unit_name)
    turn_states_machine.current_unit.set_current(true)
    await turn_states_machine.current_unit.turn_finished
    states_changed.emit(TurnStateId.NEXT_TURN)
    return


func exit() -> void:
    turn_states_machine.current_unit.set_current(false)
    super()
    return
