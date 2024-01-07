extends Marker3D

@export var _d_fire_interval_sec = 5.0
var _scn_bullet : PackedScene = preload("res://character/enemy_bullet/enemy_bullet.tscn")

func _ready():
	$FireTimer.start(_d_fire_interval_sec)	

func _on_fire_timer_timeout():
	var ins = _scn_bullet.instantiate()
	ins.set_pos( global_position, g_val.node_player.global_position)
	g_val.node_bullets.add_child(ins)
