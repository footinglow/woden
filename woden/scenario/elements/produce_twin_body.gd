extends Node

@export	var _i_produce_num = 10
@export var _d_produce_interval_sec = 0.5
var _scn_enemy = preload("res://character/enemy/twin_body.tscn")

var _i_produced_num = 0;	# 生産した数

func start_element():
	$Timer_for_produce.start(_d_produce_interval_sec)

func is_blocking_to_move_on_next_scenario() -> bool:
	# 敵キャラの生産が完了したら次のシナリオ要素に進ませるためfalseにする
	return ( _i_produced_num < _i_produce_num )

func _on_timer_for_produce_timeout():
	# 敵キャラクターのインスタンスを生成、位置を設定してシーンに追加する
	var ins = _scn_enemy.instantiate()
	ins.position.z = -200
	ins.position.x = randf_range(-25, 25)
	g_val._node_enemies.add_child(ins)
	
	# 生産完了したら、タイマーを停止する
	_i_produced_num += 1
	if ( _i_produced_num >= _i_produce_num ):
		$Timer_for_produce. stop()
