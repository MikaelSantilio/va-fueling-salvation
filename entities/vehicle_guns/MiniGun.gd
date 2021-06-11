extends Node2D

var _duration_pressed = 0

func _physics_process(delta):

	var m = get_global_mouse_position()
	var aim_speed = deg2rad(1)
	if $weapon.get_angle_to(m) > 0:
		$weapon.rotation += aim_speed
	else:
		$weapon.rotation -= aim_speed

	if Input.is_action_just_released("ui_primary_shot"):
		$MiddleShotAudio.stop()
		$EndShotAudio.play()
	
	elif Input.is_action_pressed("ui_primary_shot") and _duration_pressed > 0.25:
		$StartShotAudio.stop()
		if not $MiddleShotAudio.is_playing():
			$MiddleShotAudio.play()
		print("Segurando")
		
	elif Input.is_action_pressed("ui_primary_shot"):
		_duration_pressed += delta
		$StartShotAudio.play()
