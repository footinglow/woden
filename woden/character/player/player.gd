extends Area3D

# Player
@export var _d_speed_mps = 100.0
@export var _d_hp = 1.0

# ドラッグ操作検知用
var _f_is_screen_touch = false		# 画面にタッチ（ドラッグ含む）している場合true、タッチしていない場合はfalse
var _v2_drag_pos = Vector2.ZERO		# 最新のタッチ位置・ドラッグ位置

# タッチしたときの、３D上のタッチ位置とPlayer位置
var _v_first_touch_pos   = null
var _v_first_touch_player_pos = Vector3.ZERO

# 画面をタッチした位置から、検索する３Dオブジェクトまでの最大距離
@export var _d_ray_length_m = 1000		# [m]十分な長さにする

# レーザーの発射タイミング
@export var _scn_laser : PackedScene
@export var _d_firing_interval_sec = 0.2
var _d_firing_remain_time_sec = 0

func _input(event):
	# 画面にタッチしている状態と、タッチしていない状態を判断する
	if event is InputEventScreenTouch:
		_f_is_screen_touch = event.is_pressed()
		# ドラッグ位置（タッチ位置）を更新する
		_v2_drag_pos = event.position	
	elif event is InputEventScreenDrag:
		# ドラッグしているということは、タッチしている。（参考：InputEventScreenDragの場合、event.is_pressed()は常にfalse)
		_f_is_screen_touch = true
		# ドラッグ位置（タッチ位置）を更新する
		_v2_drag_pos = event.position	
	else:
		pass

func _physics_process(delta):
	if _f_is_screen_touch:
		var camera = get_viewport().get_camera_3d()

		# カメラを利用して3D空間のカメラの３D位置と、カメラからタッチしたピクセルを見た方向の1000m先の３D位置を計算する
		var from3d = camera.project_ray_origin(_v2_drag_pos)
		var to3d = from3d + camera.project_ray_normal(_v2_drag_pos) * _d_ray_length_m

		# 3D ray physics queryの作成
		var query = PhysicsRayQueryParameters3D.create(from3d, to3d)
		query.collide_with_areas = true		# Area3Dを検知できるようにする
		
		#　spaceと呼ばれる、物理３D空間状態の情報を利用して、Area3Dを含む衝突位置を計算する
		var space_state = get_world_3d().direct_space_state
		var result = space_state.intersect_ray(query)
		if result:
			# 衝突位置を取得
			var v_drag_pos = result.position
			v_drag_pos.y = global_position.y	# Y方向には移動しないための設定
			if _v_first_touch_pos == null :
				# 初めてタッチしたときの、3D位置を記憶する
				_v_first_touch_pos = v_drag_pos
				# 初めてタッチしたときの、プレイヤーの3D位置を記憶する
				_v_first_touch_player_pos = global_position
			else:
				pass
			
			# ３D空間の移動目標位置
			var v_target_pos = _v_first_touch_player_pos + ( v_drag_pos - _v_first_touch_pos )
			
			# Player位置から移動目標位置までの相対位置を計算
			var v_target : Vector3 = v_target_pos - global_position
			# 移動目標位置に向かう速度ベクトルを生成
			var v_velocity : Vector3 = v_target.normalized() * _d_speed_mps
			if v_target.length() < ( v_velocity * delta ).length():
				# 目的地までの距離が、delta当たりの移動量よりも小さい場合は、飛び越えてしまうため、Playerの位置を目標位置にする
				global_position = v_target_pos
			else:
				# CharacterBody3Dのvelocityに速度を設定して動かす
				position += v_velocity * delta
		else:
			# タッチ位置に衝突したものが無い
			pass
	else:
		# タッチしていない場合はnullを設定することで、次にタッチしたときに、新しいタッチ位置とPlayer位置を記憶する
		_v_first_touch_pos = null
		
	if _f_is_screen_touch:
		# タイミングをとりながらlaser発射
		if _d_firing_remain_time_sec > 0:
			# 次の発射までの残り時間を減算するのみ
			_d_firing_remain_time_sec -= delta
		else:
			# レーザーを発射する
			var scn : Area3D = _scn_laser.instantiate()
			scn.set_pos(global_position)
			g_val.node_lasers.add_child(scn)
			# 発射間隔を設定
			_d_firing_remain_time_sec = _d_firing_interval_sec
	else:
		# タッチしたときにすぐ、レーダーが発射するようにする
		_d_firing_remain_time_sec = 0

	# HPが0になった場合、Playerは消滅する
	if _d_hp <= 0:
		queue_free()
		
func _on_area_entered(area):
	# 敵もしくは敵の弾の攻撃があたったため、HPを0にする
	_d_hp = 0.0
