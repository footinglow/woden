extends Area3D

signal add_to_score(int)

@export var _d_speed_mps = 20.0
@export var _d_hp = 1
@export var _i_score = 100

func _physics_process(delta):
	global_position += Vector3(0, 0, 1) * _d_speed_mps * delta
	if _d_hp <= 0:
		add_to_score.emit(_i_score)
		queue_free()

func _on_visible_on_screen_notifier_3d_screen_exited():
	queue_free()

# HPからダメージポイントを引き算する。余った分はreturn値で返す
func calc_damage(laser_power) -> int:
	var remainder = 0
	if _d_hp <= laser_power:
		# ダメージの方が大きい
		remainder = laser_power - _d_hp
		_d_hp = 0
	else:
		# HPの方が大きい
		_d_hp -= laser_power
		remainder = 0
	# 余ったダメージポイントを返す
	return remainder
