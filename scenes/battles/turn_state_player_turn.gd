extends TurnState

class_name TurnStatePlayerTurn

func _ready() -> void:
    current_id = TurnStateId.PLAYER_TURN
    return


func enter() -> void:
    super()
    print("Player turn for unit: ", turn_states_machine.current_unit.unit_name)
    turn_states_machine.current_unit.turn_finished.connect(_on_turn_finished)
    return


func exit() -> void:
    turn_states_machine.current_unit.turn_finished.disconnect(_on_turn_finished)
    super()
    return
