extends Node

class_name TurnState

enum TurnStateId {
    ROUND_START,
    NEXT_TURN,
    PLAYER_TURN,
    ENEMY_TURN,
}

var turn_state_names: Dictionary[TurnStateId, String] = {
    TurnStateId.ROUND_START: "Round Start",
    TurnStateId.NEXT_TURN: "Next Turn",
    TurnStateId.PLAYER_TURN: "Player Turn",
    TurnStateId.ENEMY_TURN: "Enemy Turn",
}

signal states_changed(new_state: TurnStateId)

var turn_states_machine: TurnStatesMachine
var current_id: TurnStateId


func enter() -> void:
    print("Entering state: ", turn_state_names[current_id])


func exit() -> void:
    print("Exit state: ", turn_state_names[current_id])
