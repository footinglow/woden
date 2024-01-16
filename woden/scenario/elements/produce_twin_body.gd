extends Node

# 敵生成パラメータ
@export	var _i_produce_num = 10
@export var _d_produce_interval_sec = 0.5

# 敵のパラメータ
@export var _d_hp = 1
@export var _i_score = 100

var _scn_enemy = preload("res://character/enemy/twin_body.tscn")

var _i_produced_num = 0;	# 生産した数

func start_element():
	$Timer_for_produce.start(_d_produce_interval_sec)

func is_blocking_to_move_on_next_scenario() -> bool:
	# 敵キャラの生産が完了したら次のシナリオ要素に進ませるためfalseにする
	return ( _i_produced_num < _i_produce_num )

func _on_timer_for_produce_timeout():
	# 敵キャラクターのインスタンスを生成
	var ins = _scn_enemy.instantiate()

	# 敵パラメータの設定
	ins.d_enemy_hp = _d_hp
	ins.i_enemy_score = _i_score
	ins.position.z = g_val.d_visible_top_z_m
	ins.position.x = randf_range(	g_val.d_visible_top_min_x_m,
									g_val.d_visible_top_max_x_m)

	# add_to_scoreシグナルをgame.gdに接続する
	ins.add_to_score.connect( g_val.node_game._on_add_to_score )

	# 敵インスタンスをシーンツリーに追加
	g_val.node_enemies.add_child(ins)
	
	# 生産完了したら、タイマーを停止する
	_i_produced_num += 1
	if ( _i_produced_num >= _i_produce_num ):
		$Timer_for_produce. stop()
