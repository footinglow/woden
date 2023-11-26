extends Node3D

# Player
@export var m_speed_mps = 3.0

# ドラッグ操作検知用
var m_touch_pos = Vector2.ZERO		# タッチした時の位置
var m_drag_pos = Vector2.ZERO		# 現在のタッチ位置・ドラッグ位置
var m_f_is_screen_touch = false		# スクリーンにタッチ（ドラッグ含む）している場合true

# DRAG_TO_MOVEドラッグした分移動する操作方法）の時用
var m_v_base_touch_pos   = null
var m_v_base_player_pos = Vector3.ZERO

@export var m_ray_length_m = 1000		# [m]十分な長さにする

func _input(event):
	if event is InputEventScreenTouch:
		if event.is_pressed():
			# タッチしたところを初期位置として記憶する
			m_touch_pos  = event.position
			m_drag_pos = event.position
			m_f_is_screen_touch = true
			# m_touch_posを設定したときのプレイヤーの位置を基準として記憶する
			m_v_base_player_pos = $Player.global_position
		else:
			# 指を離したのを検知する
			m_f_is_screen_touch = false
			m_v_base_touch_pos = null
	elif event is InputEventScreenDrag:
		if m_touch_pos == Vector2.ZERO:
			# READY状態にタッチするとWorldが動き出すため最初のタッチが検知されないためここで初期値を設定する
			m_touch_pos = event.position
			# m_touch_posを設定したときのプレイヤーの位置を基準として記憶する
			m_v_base_player_pos = $Player.global_position
		else:
			pass
		m_drag_pos = event.position
		m_f_is_screen_touch = true

func _physics_process(delta):
	if m_f_is_screen_touch:
		var camera = get_viewport().get_camera_3d()

		# カメラを利用して3D空間のカメラ位置とタッチしたピクセルに対応する方向の1000m先の位置を計算する
		var from3d = camera.project_ray_origin(m_drag_pos)
		var to3d = from3d + camera.project_ray_normal(m_drag_pos) * m_ray_length_m

		# 3D ray physics queryの作成
		var query = PhysicsRayQueryParameters3D.create(from3d, to3d)
		query.collide_with_areas = true		# Area3Dを検知できるようにする
		
		# Godotの3Dの物理とコリジョンを保存しているspaceという情報を使用してオブジェクト検出
		var space_state = get_world_3d().direct_space_state
		var result = space_state.intersect_ray(query)
		if result:
			var v_drag_pos  = result.position
			v_drag_pos.y = 0	# Y方向には移動しない
			if m_v_base_touch_pos == null || m_touch_pos.is_equal_approx(m_drag_pos):
				m_v_base_touch_pos = v_drag_pos
			else:
				pass
			
			# ３D空間の移動先目標位置
			var v_target_pos = m_v_base_player_pos + ( v_drag_pos - m_v_base_touch_pos )
			
			# delta時間で目標位置に移動できる速度を設定してmove_and_slideする（本当はPlayerシーン内でやるべき）
			$Player.velocity =  (v_target_pos - $Player.global_position ) / delta
			$Player.move_and_slide()
			
		else:
			pass
