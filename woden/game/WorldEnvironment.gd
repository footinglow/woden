extends WorldEnvironment

var d_scroll_speed_magni = 1.0	# スクロール速度の倍率変数
var _d_speed_degps = -5.0		# 回転速度 [degree/sec]

func _process(delta):
	get_environment().sky_rotation.x += deg_to_rad(_d_speed_degps * d_scroll_speed_magni * delta)
