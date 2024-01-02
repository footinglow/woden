extends Node

@export var _d_wait_time_sec = 5.0

#override
func start_element():
	$Timer_for_wait_specified_time.start(_d_wait_time_sec)

#override
func is_blocking_to_move_on_next_scenario() -> bool:
	# タイマー稼働中は、シナリオをブロックするためtrueを返す
	return !$Timer_for_wait_specified_time.is_stopped()
