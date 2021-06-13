extends Node2D

var _duration_pressed = 0
var _start_shot_finished = false
var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()

func _physics_process(delta):
	$HeavyShot2D.pitch_scale = rng.randf_range(0.85, 1)

	var m = get_global_mouse_position()
	var aim_speed = deg2rad(1)
	if get_angle_to(m) > 0:
		rotation += aim_speed
	else:
		rotation -= aim_speed

	if Input.is_action_just_released("ui_primary_shot"):
		$weapon/fire.visible = false
		$HeavyShot2D.stop()
		$EndShotAudio.play()
	
	elif Input.is_action_pressed("ui_primary_shot"):
		$weapon/fire.visible = true
		if not $HeavyShot2D.is_playing():
			$HeavyShot2D.play()
