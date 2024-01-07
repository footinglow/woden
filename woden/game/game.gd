extends Node3D

var _scn_scenario_stage = preload("res://scenario/scenario_stage01.tscn")

var _node_scenario_ins

func _ready():
	# インスタンス化したシーンの追加先を設定する
	g_val.node_lasers = $DynamicNodes/lasers
	g_val.node_enemies = $DynamicNodes/enemy/bodies
	g_val.node_bullets = $DynamicNodes/enemy/bullets

	# Playerインスタンスを設定する
	g_val.node_player = $Player
	
	# ステージシナリオをシーンツリーに追加
	_node_scenario_ins = _scn_scenario_stage.instantiate()
	add_child(_node_scenario_ins)

func _process(delta):
	# シナリオを駆動する
	_node_scenario_ins.drive_scenario()
