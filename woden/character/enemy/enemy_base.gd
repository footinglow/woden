class_name EnemyBase extends Area3D

# 敵が共通して持つべきシグナル
signal add_to_score(int)

# 敵が共通して持つべきプロパティ
var d_enemy_hp = 1
var i_enemy_score = 100

# 撃墜チェック
# 敵 派生クラスの_physics_processからコールされることを想定
func check_destroyed():
	if d_enemy_hp <= 0:
		add_to_score.emit(i_enemy_score)
		queue_free()

# ダメージ計算処理
# HPからダメージポイントを引き算する。余った分はreturn値で返す
# レーザースクリプトからコールされることを想定
func calc_damage(laser_power) -> int:
	var remainder = 0
	if d_enemy_hp <= laser_power:
		# ダメージの方が大きい
		remainder = laser_power - d_enemy_hp
		d_enemy_hp = 0
	else:
		# HPの方が大きい
		d_enemy_hp -= laser_power
		remainder = 0
	# 余ったダメージポイントを返す
	return remainder
