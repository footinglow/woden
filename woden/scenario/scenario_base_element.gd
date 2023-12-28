class_name scenario_base_element

extends Node

# シナリオ実行対象となったときに一度だけ実行される
func start_element():
	pass

# 次のシナリオに進むのを待たせる場合はtrueを返す
func is_blocking_to_move_on_next_scenario() -> bool:
	return false

