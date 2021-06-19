extends Node2D

var _duration_pressed = 0
var _start_shot_finished = false
var rng = RandomNumberGenerator.new()
var Bullet = preload("res://entities/vehicle_guns/Bullet1.tscn")
var echo_click = false
signal shoot(bullet, shoot_transform)

func _ready():
	Global.player_bullets = 10000
	rng.randomize()

func _physics_process(delta):
	$MiddleShotAudio.pitch_scale = rng.randf_range(0.75, 1)
	echo_click = not echo_click
	var m = get_global_mouse_position()
	var aim_speed = deg2rad(2)
	if get_angle_to(m) > 0:
		rotation += aim_speed
	else:
		rotation -= aim_speed

	if Input.is_action_just_released("ui_primary_shot"):
		$MiddleShotAudio.stop()
		$EndShotAudio.play()
		$weapon/fire.visible = false
		_start_shot_finished = false
	
	elif echo_click and Input.is_action_pressed("ui_primary_shot") and _start_shot_finished:
		$StartShotAudio.stop()
		$weapon/fire.visible = true 
		#emit_signal("shoot", Bullet, get_global_rotation(), get_global_position())
		emit_signal("shoot", Bullet, $BulletSpawn.get_global_transform())
		#emit_signal("create_bullet", global_position)
		
		if not $MiddleShotAudio.is_playing():
			$MiddleShotAudio.play()

	elif Input.is_action_just_pressed("ui_primary_shot"):
		_duration_pressed += delta
		if not $StartShotAudio.is_playing(): 
			$StartShotAudio.play()



func _on_StartShotAudio_finished():
	_start_shot_finished = true

