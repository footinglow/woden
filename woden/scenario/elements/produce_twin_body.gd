extends scenario_base_element

@export	var _i_produce_num = 10
@export var _d_produce_interval_sec = 0.5
var _scn_generator = preload("res://character/enemy/twin_body.tscn")

var _d_remain_time_sec = _d_produce_interval_sec
var _i_remain_num = _i_produce_num;

func produce(delta):
	_d_remain_time_sec -= delta
	if _d_remain_time_sec <= 0.0 and _i_remain_num > 0:
		var ins = _scn_generator.instantiate()
		ins.position.z = -135
		ins.position.x = randf() * 100 - 50.0
		add_child(ins)
		
		_i_remain_num -= 1
		_d_remain_time_sec = _d_produce_interval_sec

func wait_scenario(delta) -> bool:
	if _i_remain_num > 0:
		# 敵インスタンスを生成中はtrueを返してシナリオを勧めない
		return true
	else:
		# シナリオを次に進める
		return false
