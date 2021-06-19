extends Control


func _physics_process(delta):
	update_kmh()

func update_kmh():
	# $VelocityLabel.text = String(abs(Global.player_speed_kmh))
	$ControlPointer.rect_rotation = 1.6875 * abs(Global.player_speed_kmh)
