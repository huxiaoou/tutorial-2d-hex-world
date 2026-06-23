extends Node

class_name TurnState

enum TurnStateId {
    ROUND_START,
    NEXT_TURN,
    PLAYER_TURN,
    ENEMY_TURN,
}

signal states_changed(new_state: TurnStateId)

var turn_states_machine: TurnStatesMachine
var current_id: TurnStateId


func enter() -> void:
    print("Entering state: ", current_id)


func exit() -> void:
    print("Exit state: ", current_id)


func _on_turn_finished() -> void:
    states_changed.emit(TurnStateId.NEXT_TURN)
    return
