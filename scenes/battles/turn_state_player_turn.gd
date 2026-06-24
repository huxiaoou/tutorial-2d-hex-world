extends TurnState

class_name TurnStatePlayerTurn

func _ready() -> void:
    current_id = TurnStateId.PLAYER_TURN
    return


func enter() -> void:
    super()
    print("Player turn for unit: ", turn_states_machine.current_unit.unit_name)
    await turn_states_machine.current_unit.turn_finished
    states_changed.emit(TurnStateId.NEXT_TURN)
    return
