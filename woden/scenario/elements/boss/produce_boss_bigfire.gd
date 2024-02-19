extends Node3D

var _scn_enemy = preload("res://character/boss/boss_bigfire.tscn")

# 敵のパラメータ
@export var _d_hp = 1000
@export var _i_score = 100

func start_element():
	# シーンのインスタンスを生成
	var ins = _scn_enemy.instantiate()
	# 敵パラメータの設定
	ins.d_enemy_hp = _d_hp
	ins.i_enemy_score = _i_score
	# パラメータの設定
	ins.position.z = g_val.d_visible_bottom_z_m + 25.0	# 完全に画面外に移動するように
	ins.position.x = 0.0

	# インスタンスを敵管理用ノードに追加
	g_val.node_enemies.add_child(ins)

func is_blocking_to_move_on_next_scenario() -> bool:
	return false

