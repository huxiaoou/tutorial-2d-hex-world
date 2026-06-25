extends Node

signal unit_selected(unit: UnitTurnBased)
signal unit_deselected(unit: UnitTurnBased)


func on_unit_selected(unit: UnitTurnBased):
    unit_selected.emit(unit)


func on_unit_deselected(unit: UnitTurnBased):
    unit_deselected.emit(unit)
