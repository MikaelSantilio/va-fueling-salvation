extends RigidBody2D

export var SPEED = 4
export var hp = 1000
export var lava_damage = 300

export var max_speed : int = 300
export var acceleration : float = 1000.0
export var max_torque_impulse : int = 30000
var is_horn_pressed = false
var _duration_pressed = 0
var _ac_delta = 0

var speed : float = 0.0
var is_on_lava = false
var is_rollover = false
onready var timer = $RolloverTimer
export var reset_time : float = 2.5
var rng = RandomNumberGenerator.new()

var speed_car : float;

func _ready():
	 #= 0.1
	rng.randomize()


func _physics_process(delta):

	_ac_delta += delta * 2.5
	#speed_car = transform.basis_xform_inv(linear_velocity).x/8
	speed_car = (transform.basis_xform_inv(linear_velocity).x * 0.014)* 3.6
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
	if Input.is_action_pressed("ui_right"):
		# $r_wheel.angular_velocity += SPEED
		# $l_wheel.angular_velocity += SPEED

		speed += acceleration
		speed = clamp(speed, speed, max_torque_impulse)
		$l_wheel.apply_torque_impulse(speed)
		$r_wheel.apply_torque_impulse(speed)


	elif Input.is_action_pressed("ui_left"):
		#$r_wheel.angular_velocity -= SPEED
		#$l_wheel.angular_velocity -= SPEED
		
		speed -= acceleration
		speed = clamp(speed, -max_torque_impulse, speed)
		$l_wheel.apply_torque_impulse(speed)
		$r_wheel.apply_torque_impulse(speed)
	
	elif not is_on_lava and Input.is_action_pressed("ui_up"):
		rotation_degrees -= 0.5
	
	elif not is_on_lava and Input.is_action_pressed("ui_down"):
		rotation_degrees += 0.5


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


func siren_light_frequence(frequence, delta):
	if fmod(delta,frequence) <= 0.3:
		$SirenLight.enabled = true
	else:
		#print(fmod(delta,frequence))
		#print(delta)
		$SirenLight.enabled = false
