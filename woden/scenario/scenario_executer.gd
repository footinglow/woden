extends Node

var _i_run_scenario_elem_num = 1		# シナリオノード全体のうち、実行対象の数

func run(delta):
	# シナリオ要素を先頭から、実行対象ノードまで実行する
	for i in range(_i_run_scenario_elem_num):
		get_child(i).produce(delta)	

	# 最後のノード
	if get_child(_i_run_scenario_elem_num-1).wait_scenario(delta):
		pass
	else:
		if _i_run_scenario_elem_num < get_child_count():
			_i_run_scenario_elem_num += 1
			
