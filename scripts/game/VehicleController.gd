extends RigidBody2D

export var hp = 1000
export var lava_damage = 300

export var max_speed_kmh : int = 160
export var acceleration_px : float = 600.0
export var max_torque_impulse : int = 20000
var _duration_pressed = 0

var speed : float = 0.0
var is_on_lava = false
var is_rollover = false
var player_die : bool = false
onready var timer = $RolloverTimer
export var reset_time : float = 2.5
var rng = RandomNumberGenerator.new()

var speed_car : float;

signal shoot_car(bullet, shoot_transform)
#signal shoot(bullet, direction, location)

func _ready():
	Global.global_hp = hp
	Global.player_gas = 1000
	rng.randomize()

func _physics_process(delta):

	#speed_car = transform.basis_xform_inv(linear_velocity).x/8
	speed_car = (transform.basis_xform_inv(linear_velocity).x * 0.014)* 3.6
	Global.player_speed_kmh = speed_car
	# Velocidade em KM/h
	#print((transform.basis_xform_inv(linear_velocity).x * 0.014)* 3.6)

	if speed_car/100 + 1 > 3:
		$EngineAudio.pitch_scale = 3
	elif speed_car/100 + 1 < 1:
		$EngineAudio.pitch_scale = 1
	else:
		$EngineAudio.pitch_scale = speed_car/100 + 1
	#print(lower + (upper - lower) * speed_car)
	#print((speed_car - lower) / (upper - speed_car))
	
	#$EngineAudio.pitch_scale = lower + (upper - lower) * speed_car
	if Input.is_action_pressed("ui_right") and speed_car < max_speed_kmh and not player_die:

		speed += acceleration_px
		speed = clamp(speed, speed, max_torque_impulse)
		$l_wheel.apply_torque_impulse(speed)
		$r_wheel.apply_torque_impulse(speed)


	elif Input.is_action_pressed("ui_left") and speed_car < max_speed_kmh and not player_die:
		speed -= acceleration_px
		speed = clamp(speed, -max_torque_impulse, speed)
		$l_wheel.apply_torque_impulse(speed)
		$r_wheel.apply_torque_impulse(speed)
	
	elif Input.is_action_pressed("ui_up") and not player_die:
		rotation_degrees -= 0.5
	
	elif Input.is_action_pressed("ui_down") and not player_die:
		rotation_degrees += 0.5
		
	if Input.is_action_just_released("ui_horn") and not player_die:
		$HornSound.stop()
	
	elif Input.is_action_pressed("ui_horn") and not player_die:
		
		if not $HornSound.is_playing():
			$HornSound.play()
	
	if Global.global_hp <= 0 and not player_die:
		var DieScreen = load("res://UI/DScreen.tscn").instance()
		instance_from_id(Global.level_id).add_child(DieScreen)
		player_die = true
		Global.other_screen_open = true

func _on_LavaDetector_area_entered(area):
	is_on_lava = true
	print('Entrou na lava')


func _on_LavaDetector_area_exited(area):
	is_on_lava = false
	print('Saiu da lava')

func _on_RolloverDetector_body_entered(body):
	print('Capotou')
	is_rollover = true
	timer.start(reset_time)


func _on_RolloverTimer_timeout():
	if is_rollover:
		print('End game')


func _on_RolloverDetector_body_exited(body):
	print('Descapotou')
	is_rollover = false


#func _on_Weapon_shoot(bullet, direction, location):
func _on_Weapon_shoot(bullet, shoot_transform):
	#emit_signal("shoot", bullet, direction, location)
	emit_signal("shoot_car", bullet, shoot_transform)


func _on_EnemyBulletDetector_area_entered(area):
	Global.global_hp -= 1
