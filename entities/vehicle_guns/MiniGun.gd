extends Node2D

var _duration_pressed = 0
var _start_shot_finished = false
var rng = RandomNumberGenerator.new()

func _ready():
	 #= 0.1
	rng.randomize()

func _physics_process(delta):
	$MiddleShotAudio.pitch_scale = rng.randf_range(0.75, 1)
	var m = get_global_mouse_position()
	var aim_speed = deg2rad(1)
	if $weapon.get_angle_to(m) > 0:
		$weapon.rotation += aim_speed
	else:
		$weapon.rotation -= aim_speed

	if Input.is_action_just_released("ui_primary_shot"):
		$MiddleShotAudio.stop()
		$EndShotAudio.play()
		$weapon/fire.visible = false
		_start_shot_finished = false
	
	elif Input.is_action_pressed("ui_primary_shot") and _start_shot_finished:
		$StartShotAudio.stop()
		$weapon/fire.visible = true
		if not $MiddleShotAudio.is_playing():
			$MiddleShotAudio.play()

	elif Input.is_action_just_pressed("ui_primary_shot"):
		_duration_pressed += delta
		if not $StartShotAudio.is_playing(): 
			$StartShotAudio.play()


func _on_StartShotAudio_finished():
	_start_shot_finished = true

