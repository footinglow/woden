extends Node

var _i_started_element_idx = 0		# 開始指示済みのシナリオ要素のインデックス

func _ready():
	get_child(0).start_element()
	
func drive_scenario():
	if get_child(_i_started_element_idx).is_blocking_to_move_on_next_scenario():
		# ブロックされているので、シナリオは進めない
		pass
	else:
		if _i_started_element_idx < ( get_child_count() - 1 ):
			# シナリオを1個進めて、開始する
			_i_started_element_idx += 1
			get_child(_i_started_element_idx).start_element()
