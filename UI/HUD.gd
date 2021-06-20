extends Control


func _physics_process(delta):
	update_kmh()

func update_kmh():
	# $VelocityLabel.text = String(abs(Global.player_speed_kmh))
	# 1.6875
	$Speedometer.get_node("ControlPointer").rect_rotation = 1.74 * abs(Global.player_speed_kmh)
	$Label.text = String(Global.player_speed_kmh)
