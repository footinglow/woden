extends Area3D

var _d_speed_mps = 50.0		# 単位はm/s　
var d_power_point = 1
var v_dir = Vector3(0, 0, -1)

func set_pos(player_pos):
	global_position = player_pos
	
func _physics_process(delta):
	global_position += v_dir * _d_speed_mps * delta
	if d_power_point <=0:
		queue_free()

# 画面外に出た場合、消える
func _on_visible_on_screen_notifier_3d_screen_exited():
	queue_free()

func _on_area_entered(area_enemy):
	d_power_point = area_enemy.calc_damage(d_power_point)

