extends Control

func _physics_process(delta):
	update_kmh()
	update_life_bar()
	update_bullet_count()
	#update_gas_bar()

func update_kmh():
	# $VelocityLabel.text = String(abs(Global.player_speed_kmh))
	# 1.6875
	$Speedometer.get_node("ControlPointer").rect_rotation = 1.74 * abs(Global.player_speed_kmh)
	$Label.text = String(Global.player_speed_kmh)

func update_life_bar():
	$InfoBars/EngineBar.value = Global.global_hp


func update_bullet_count():
	$InfoBars/BulletCount.text = String(Global.player_bullets)
	
func update_gas_bar():
	$InfoBars/GasBar.value = Global.player_gas
