extends Node3D

# ゲーム画面の見える範囲
# ゲーム画面の上端をtop、下端をbotommとする
var d_visible_top_y_m = -200.0
var d_visible_top_min_x_m = -25.0
var d_visible_top_max_x_m =  25.0

# gameのインスタンス
var node_game : Node3D = null 

# 生成したインスタンスの追加先
var node_lasers : Node3D = null
var node_enemies : Node3D = null 
var node_bullets : Node3D  = null

# Playerのインスタンス
var node_player : Area3D = null 
