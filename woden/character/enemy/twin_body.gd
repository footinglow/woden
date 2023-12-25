extends Area3D

@export var _d_speed_mps = 20.0

func _physics_process(delta):
	global_position += Vector3(0, 0, 1) * _d_speed_mps * delta

func _on_visible_on_screen_notifier_3d_screen_exited():
	queue_free()
