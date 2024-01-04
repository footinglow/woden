extends Area3D

@export var _d_speed_mps = 25.0		# 単位はm/s　
@export var _d_power_point = 1
@export var _v_dir = Vector3(0, 0, -1)

func set_pos(player_pos):
	global_position = player_pos
	
func _physics_process(delta):
	global_position += _v_dir * _d_speed_mps * delta
	if _d_power_point <=0:
		queue_free()

# 画面外に出た場合、消える
func _on_visible_on_screen_notifier_3d_screen_exited():
	queue_free()

func _on_area_entered(area_enemy):
	_d_power_point = area_enemy.calc_damage(_d_power_point)

