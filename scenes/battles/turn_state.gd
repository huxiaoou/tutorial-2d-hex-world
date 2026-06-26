extends Node

class_name TurnState

enum TurnStateId {
    ROUND_START,
    NEXT_TURN,
    PLAYER_TURN,
    ENEMY_TURN,
}

signal state_changed(new_state: TurnStateId)

var turn_states_machine: TurnStatesMachine
var current_id: TurnStateId


func enter() -> void:
    print("Entering state: ", TurnStateId.keys()[current_id])


func exit() -> void:
    print("Exit state: ", TurnStateId.keys()[current_id])
