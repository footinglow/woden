extends Area3D

@export var _d_speed_mps = 25.0		# 単位はm/s　
@export var _v_dir = Vector3(0, 0, -1)

func set_pos(player_pos):
	global_position = player_pos
	
func _physics_process(delta):
	global_position += _v_dir * _d_speed_mps * delta

# 画面外に出た場合、消える
func _on_visible_on_screen_notifier_3d_screen_exited():
	queue_free()
