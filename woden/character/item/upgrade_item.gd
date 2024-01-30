extends Area3D

@export var d_cycle_val = 0.0# : float = 0.0	# AnimationPlayerで変更
var _d_speed_mps = 20.0

var _material_body : StandardMaterial3D = null
var _mesh_text : TextMesh = null
var en_item_kind = g_val.EnItemKind.SPEED_UP

func _ready():
	# Bodyマテリアル用
	_material_body = ($body.mesh as SphereMesh).material
	# P/Sのテキスト変更用
	_mesh_text = $body/text.mesh

func _physics_process(delta):
	# 移動処理
	global_position += Vector3(0, 0, 1) * _d_speed_mps * delta
	# アニメーション
	_material_body.emission_energy_multiplier = d_cycle_val

func _on_visible_on_screen_notifier_3d_screen_exited():
	queue_free()

func _on_timer_timeout():
	# アップグレードアイテムの種別を切り替える
	en_item_kind = g_val.EnItemKind.POWER_UP if en_item_kind == g_val.EnItemKind.SPEED_UP else g_val.EnItemKind.SPEED_UP
	
	# アップグレードアイテムの種別に応じて、デザインを変更する
	if en_item_kind == g_val.EnItemKind.SPEED_UP:
		# Speedに変更
		_mesh_text.text = "S"
		_material_body.albedo_color = Color(0.5, 0.5, 1, 1)
	else:
		# Powerに変更
		_mesh_text.text = "P"
		_material_body.albedo_color = Color(1, 0, 0, 1)
