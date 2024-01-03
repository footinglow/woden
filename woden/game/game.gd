extends Node3D

var _scn_scenario_stage = preload("res://scenario/scenario_stage01.tscn")

var _node_scenario_ins

func _ready():
	_node_scenario_ins = _scn_scenario_stage.instantiate()
	add_child(_node_scenario_ins)

func _process(delta):
	# シナリオを駆動する
	_node_scenario_ins.drive_scenario()
