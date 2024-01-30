extends Node3D

# アップグレードアイテムの種別
enum EnItemKind{
	POWER_UP,
	SPEED_UP	
}

# ゲーム画面の見える範囲
# ゲーム画面の上端をtop、下端をbotommとする
var d_visible_top_z_m = -200.0
var d_visible_top_min_x_m = -75.0
var d_visible_top_max_x_m =  75.0

var d_visible_bottom_z_m = -15.0
var d_visible_bottom_min_x_m = -25.0
var d_visible_bottom_max_x_m =  25.0


# gameのインスタンス
var node_game : Node3D = null 

# 生成したインスタンスの追加先
var node_lasers : Node3D = null
var node_enemies : Node3D = null 
var node_bullets : Node3D  = null
var node_others : Node3D  = null

# Playerのインスタンス
var node_player : Area3D = null 
