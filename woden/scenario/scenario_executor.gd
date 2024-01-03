extends Node

var _i_started_element_idx = 0		# 実行中のシナリオ要素のインデックス

func _ready():
	# 初期設定時に、先頭のシナリオ要素を開始する
	get_child(0).start_element()
	
func drive_scenario():
	if get_child(_i_started_element_idx).is_blocking_to_move_on_next_scenario():
		# シナリオ要素は進めない
		pass
	else:
		if _i_started_element_idx < ( get_child_count() - 1 ):
			# 次のシナリオ要素を開始する
			_i_started_element_idx += 1
			get_child(_i_started_element_idx).start_element()
		else:
			# シナリオ要素無し
			pass
