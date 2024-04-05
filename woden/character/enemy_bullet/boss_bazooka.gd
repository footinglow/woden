extends Area3D

var _d_speed_mps = 50.0
var _v_dir = Vector3(0, 0, 1)

func set_pos(v_pos):
	global_position = v_pos

func _physics_process(delta):
	position += _v_dir * _d_speed_mps * delta
	
	# 画面外の場合は、消去する
	if !$VisibleOnScreenNotifier3D.is_on_screen():
		queue_free()
