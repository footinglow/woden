extends Node3D

var _scn_enemy = preload("res://character/item/upgrade_item.tscn")

func start_element():
	# シーンのインスタンスを生成
	var ins = _scn_enemy.instantiate()

	# パラメータの設定
	ins.position.z = g_val.d_visible_top_z_m
	ins.position.x = randf_range(	g_val.d_visible_bottom_min_x_m,
									g_val.d_visible_bottom_max_x_m)

	# アイテムをシーンツリーに追加
	g_val.node_others.add_child(ins)

func is_blocking_to_move_on_next_scenario() -> bool:
	return false

