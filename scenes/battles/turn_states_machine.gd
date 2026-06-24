extends Node

class_name TurnStatesMachine

@onready var round_start: TurnStateRoundStart = $RoundStart
@onready var next_turn: TurnStateNextTurn = $NextTurn
@onready var player_turn: TurnStatePlayerTurn = $PlayerTurn
@onready var enemy_turn: TurnStateEnemyTurn = $EnemyTurn

var states: Dictionary[TurnState.TurnStateId, TurnState] = { }
var units_queue: Array[UnitTurnBased] = []
var current_unit: UnitTurnBased = null
var current_state: TurnState = null


func _ready() -> void:
    states = {
        TurnState.TurnStateId.ROUND_START: round_start,
        TurnState.TurnStateId.NEXT_TURN: next_turn,
        TurnState.TurnStateId.PLAYER_TURN: player_turn,
        TurnState.TurnStateId.ENEMY_TURN: enemy_turn,
    }

    for state: TurnState in states.values():
        state.turn_states_machine = self
        state.states_changed.connect(_on_state_changed)

    current_state = round_start
    current_state.enter()
    return


func _on_state_changed(new_state: TurnState.TurnStateId) -> void:
    if current_state != null:
        current_state.exit()
    current_state = states[new_state]
    current_state.enter()
    return
