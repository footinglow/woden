extends Marker3D

var _d_fire_interval_sec = 2.0
var _i_fire_interval_deg = 20

var _scn_bullet : PackedScene = preload("res://character/enemy_bullet/enemy_bullet.tscn")

func _ready():
	$FireTimer.start(_d_fire_interval_sec)	

func _on_fire_timer_timeout():
	for deg in range(0, 360, _i_fire_interval_deg):
		var ins = _scn_bullet.instantiate()
		var dir = Vector3(cos(deg_to_rad(deg)), 0.0, sin(deg_to_rad(deg)))		
		ins.set_pos( global_position, global_position + dir)
		g_val.node_bullets.add_child(ins)
