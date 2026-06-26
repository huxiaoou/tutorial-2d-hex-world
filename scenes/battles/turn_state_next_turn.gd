extends TurnState

class_name TurnStateNextTurn

func _ready() -> void:
    current_id = TurnStateId.NEXT_TURN
    return


func enter() -> void:
    super()
    if turn_states_machine.units_queue.is_empty():
        state_changed.emit(TurnStateId.ROUND_START)
        return

    turn_states_machine.current_unit = turn_states_machine.units_queue.pop_front()
    if turn_states_machine.current_unit.is_player:
        state_changed.emit(TurnStateId.PLAYER_TURN)
    else:
        state_changed.emit(TurnStateId.ENEMY_TURN)
    return
