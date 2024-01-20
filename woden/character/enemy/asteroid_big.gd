extends EnemyBase

# 固有のプロパティ
var d_speed_mps = 25.0
var v_dir = Vector3(0, 0, 1)

func _physics_process(delta):
	# 撃墜チェック
	super.check_destroyed()
	# 移動処理
	global_position += v_dir * d_speed_mps * delta
	
func _on_visible_on_screen_notifier_3d_screen_exited():
	queue_free()
