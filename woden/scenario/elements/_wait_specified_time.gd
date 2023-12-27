#extends Node
extends scenario_base_element

@export var _d_wait_time_sec = 5.0

var _d_remain_timer_sec = _d_wait_time_sec

func wait_scenario(delta) -> bool:
	if _d_remain_timer_sec <= 0.0:
		return false
	else:
		_d_remain_timer_sec -= delta
		return true
