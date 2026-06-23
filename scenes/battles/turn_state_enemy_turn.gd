extends TurnState

class_name TurnStateEnemyTurn

func _ready() -> void:
    current_id = TurnStateId.ENEMY_TURN
    return


func enter() -> void:
    super()
    print("Enemy turn for unit: ", turn_states_machine.current_unit.unit_name)
    turn_states_machine.current_unit.turn_finished.connect(_on_turn_finished)
    turn_states_machine.current_unit.ai_take_action()
    return


func exit() -> void:
    turn_states_machine.current_unit.turn_finished.disconnect(_on_turn_finished)
    super()
    return
