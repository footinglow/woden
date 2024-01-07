extends Area3D

@export var _d_speed_mps = 25.0
@export var _d_rotate_speed_degps = 180

var _v_dir = Vector3.ZERO

func set_pos(v_pos, v_target_pos):
	global_position = v_pos
	_v_dir = ( v_target_pos - v_pos).normalized()

func _physics_process(delta):
	position += _v_dir * _d_speed_mps * delta
	rotate_y(deg_to_rad(_d_rotate_speed_degps * delta))

func _on_visible_on_screen_notifier_3d_screen_exited():
	queue_free()
