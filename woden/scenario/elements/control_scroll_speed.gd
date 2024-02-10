extends Node

@export var _d_target_scroll_magni = 7.0	# 目標とするスクロール速度の倍率
@export var _d_period_time_sec = 5.0		# 目標倍率完了時間

var _d_init_speed_magni = 1.0

func start_element():
	# シナリオ要素開始時点の、スクロール倍率変数を取得
	_d_init_speed_magni = g_val.node_world.d_scroll_speed_magni
	# タイマー開始
	$Timer.start(_d_period_time_sec)

func is_blocking_to_move_on_next_scenario() -> bool:
	# シナリオを次に進める
	return false

func _physics_process(delta):
	if !$Timer.is_stopped():
		# タイマーが動いている間はスクロール速度倍率を制御する
		var d_past_time = _d_period_time_sec - $Timer.time_left
		var sc_magni = remap(
					d_past_time,								# value
					0,					_d_period_time_sec,		# istart, istop
					_d_init_speed_magni,_d_target_scroll_magni	# ostart, ostop
				)
		g_val.node_world.d_scroll_speed_magni = sc_magni
	else:
		pass

