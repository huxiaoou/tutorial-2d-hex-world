extends TurnState

class_name TurnStateRoundStart

func _ready() -> void:
    current_id = TurnStateId.ROUND_START
    return


func enter() -> void:
    super()
    var units_queue: Array[UnitTurnBased] = []
    for node: Node in get_tree().get_nodes_in_group(&"units"):
        if node is UnitTurnBased:
            units_queue.append(node)
            print(node.unit_name)
    units_queue.sort_custom(UnitTurnBased.is_quicker)
    turn_states_machine.units_queue = units_queue
    state_changed.emit(TurnStateId.NEXT_TURN)
    return
