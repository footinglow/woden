extends Node

func start_element():
	pass
	
func is_blocking_to_move_on_next_scenario() -> bool:
	# 敵が残っている場合、シナリオは進めない
	if g_val.node_enemies.get_child_count() > 0:
		return true
	# 敵の弾が残っている場合、シナリオは進めない
	if g_val.node_bullets.get_child_count() > 0:
		return true
	# アイテムが残っている場合、シナリオは進めない
	if g_val.node_others.get_child_count() > 0:
		return true

	# シナリオを進める
	return false
