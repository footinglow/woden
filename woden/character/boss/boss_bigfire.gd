extends EnemyBase

# 動作モード
enum BigFireMode {
	RETURN_TO_BASE_POS,		# 動作モード1:ベース位置に戻る
	REPEAT_LATERAL,			# 動作モード2:反復横移動
	RUSH_FORWARD			# 動作モード3:突進
}
# 現在の動作モードを保持する変数
var _en_mode : BigFireMode

# 移動目標位置
var _v_target_pos : Vector3

# 移動速度の上限
var _d_min_vx_mps = -30.0	# 反復横移動の最高速度
var _d_max_vx_mps = 30.0	# 反復横移動の最高速度
var _d_min_vz_mps = -10.0	# 突進の最高速度
var _d_max_vz_mps = 40.0	# ベース位置に戻る時の最高速度

# パラメータ
var _d_base_pos_z_m = -100		# ベース位置のZ座標
var _d_rush_target_pos_z_m = g_val.d_visible_bottom_z_m + 25.0
								# 突進目標位置のZ座標（画面外の機体が見えなくなる位置）
var _i_repeat_max_cnt = 5		# 反復横移動の回数

# 反復横移動の残り回数
var _i_repeat_remain_cnt

func _ready():
	# 動作モードを初期化する
	init_return_to_base_pos()

func _physics_process(delta):
	# 撃墜チェック
	super.check_destroyed()
	# 移動処理
	match( _en_mode ):
		BigFireMode.RETURN_TO_BASE_POS:
			move_toward_target_pos(delta)
			if is_reached_target_pos():
				init_repeat_lateral()
		BigFireMode.REPEAT_LATERAL:
			process_repeat_lateral(delta)
			# 左右への移動を一定回数繰り返した場合、突進動作にする
			if _i_repeat_remain_cnt <= 0:
				init_rush_forward()
		BigFireMode.RUSH_FORWARD:
			move_toward_target_pos(delta)
			if is_reached_target_pos():
				init_return_to_base_pos()

# 目標位置との差分を速度にして、移動する
func move_toward_target_pos(delta):
	var velocity = _v_target_pos - global_position
	velocity.x = clampf(velocity.x, _d_min_vx_mps, _d_max_vx_mps)
	velocity.z = clampf(velocity.z, _d_min_vz_mps, _d_max_vz_mps)
	global_position += velocity * delta

# 目標位置に移動完了判定
func is_reached_target_pos() -> bool:
	return ( global_position.distance_to( _v_target_pos ) < 1.0 )

# 動作モード1:ベース位置に戻る
func init_return_to_base_pos():
	_en_mode = BigFireMode.RETURN_TO_BASE_POS
	# 移動目標位置をベース位置に設定
	_v_target_pos = Vector3(
						global_position.x,
						global_position.y,
						_d_base_pos_z_m )

# 動作モード2:反復横移動
func init_repeat_lateral():
	_en_mode = BigFireMode.REPEAT_LATERAL
	# 反復横跳びの残り回数を初期化
	_i_repeat_remain_cnt = _i_repeat_max_cnt
	# 移動目標位置を設定
	var target_x 
	if global_position.x < 0:
		target_x = g_val.d_visible_bottom_max_x_m
	else:
		target_x = -g_val.d_visible_bottom_max_x_m
	_v_target_pos = Vector3(
						target_x,
						global_position.y,
						global_position.z )

func process_repeat_lateral(delta):
	move_toward_target_pos(delta)	
	
	if is_reached_target_pos():
		# 移動目標位置をX軸の反対側にする
		_v_target_pos.x = -_v_target_pos.x
		# カウントダウン
		_i_repeat_remain_cnt -= 1
	
# 動作モード3:突進
func init_rush_forward():
	_en_mode = BigFireMode.RUSH_FORWARD
	# 移動目標位置を突進目標位置（画面外の機体が見えなくなる位置）に設定
	_v_target_pos = Vector3(
						global_position.x,
						global_position.y,
						_d_rush_target_pos_z_m )
