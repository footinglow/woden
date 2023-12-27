class_name scenario_base_element

extends Node

func wait_scenario(delta) -> bool:
	# falseを返すと、次のシナリオ要素に進むtrueを返すと、進まずwaitする）
	return false

func produce(delta):
	# 処理をする。一度実行対象のシナリオ要素になると、ずっと呼ばれ続ける
	pass

