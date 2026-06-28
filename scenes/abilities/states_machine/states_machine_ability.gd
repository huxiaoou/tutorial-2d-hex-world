extends Node

class_name StatesMachineAbility

@onready var deactivated: StateAbilityDeactivated = $Deactivated
@onready var targeting: StateAbilityTargeting = $Targeting
@onready var casting: StateAbilityCasting = $Casting

var states: Dictionary[StateAbility.StateAbilityId, StateAbility] = { }
var ability: Ability = null
var curr_state: StateAbility = null


func _ready() -> void:
    states = {
        StateAbility.StateAbilityId.DEACTIVATED: deactivated,
        StateAbility.StateAbilityId.TARGETING: targeting,
        StateAbility.StateAbilityId.CASTING: casting,
    }

    for state: StateAbility in states.values():
        state.sma = self
        state.state_changed.connect(_on_state_changed)
    return


func is_deactivated() -> bool:
    return curr_state == deactivated


func is_targeting() -> bool:
    return curr_state == targeting


func is_casting() -> bool:
    return curr_state == casting


func setup(_ability: Ability) -> void:
    ability = _ability
    curr_state = deactivated
    curr_state.enter()
    return


func _on_state_changed(new_state: StateAbility.StateAbilityId) -> void:
    if curr_state != null:
        curr_state.exit()
    curr_state = states[new_state]
    curr_state.enter()
    return


func _process(delta: float) -> void:
    if curr_state != null:
        curr_state.process(delta)
    return


func _physics_process(delta: float) -> void:
    if curr_state != null:
        curr_state.physics_process(delta)
    return


func _unhandled_input(event: InputEvent) -> void:
    if curr_state != null:
        curr_state.unhandled_input(event)
    return
