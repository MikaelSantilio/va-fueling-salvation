extends RigidBody2D

export var SPEED = 8
export var hp = 1000
export var lava_damage = 300

export var max_speed : int = 300
export var acceleration : float = 2000.0
export var max_torque_impulse : int = 30000
var is_horn_pressed = false
var _duration_pressed = 0
var _ac_delta = 0

var speed : float = 0.0
var is_on_lava = false
var is_rollover = false
onready var timer = $RolloverTimer
export var reset_time : float = 2.5


func _physics_process(delta):

	_ac_delta += delta * 2.5

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
	
	
	
	if Input.is_action_just_released("ui_horn"):
		$horn22D.stop()
		if not $horn2D.is_playing():
			$horn2D.play()
		else:
			$horn2D.stop()
		print("just released")
		_duration_pressed = 0
	
	elif Input.is_action_pressed("ui_horn") and _duration_pressed > 0.25:
		$horn2D.stop()
		if not $horn22D.is_playing():
			$horn22D.play()
		print("Segurando")
	
	elif Input.is_action_pressed("ui_horn"):
		_duration_pressed += delta
	# siren_light_frequence(0.45, _ac_delta)
	if is_on_lava and hp > 0:
		if hp < lava_damage:
			hp = 0
		else:
			hp -= lava_damage
		print(hp)

func calculate_speed_kmh(wheel: RigidBody2D) -> int:
		var rpm = abs(wheel.angular_velocity) / (2 * PI / 60)
		var wheel_size = wheel.get_node("Sprite").texture.get_size().y
		return int(0.1885 * rpm * 0.0127 * wheel_size)

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
