extends Node2D

var speed = 2000
onready var obj = get_parent().get_node("car")
onready var drone_pos = obj.get_node("DronePosition2D")
onready var drone_aim_pos = obj.get_node("DroneAim")
onready var Bullet = preload("res://entities/vehicle_guns/DroneBullet.tscn")
var rng = RandomNumberGenerator.new()
var vector_2 : Vector2
signal drone_shoot(bullet, shoot_transform)

func _ready():
	Global.player_bullets = 10000
	rng.randomize()

func _physics_process(delta):
	speed = Global.player_speed_kmh / 0.014 / 3.6
	speed = abs(speed)
	
	vector_2 = global_position
	if vector_2.distance_to(drone_pos.global_position) > 3:
		set_global_position(vector_2.move_toward(drone_pos.global_position, speed * delta))

	$Weapon/HeavyShot2D.pitch_scale = rng.randf_range(0.85, 1)

	#shoot_on_player()
	$Weapon.look_at(drone_aim_pos.get_global_position())



func shoot_on_player():
	$Weapon/weapon/fire.visible = true
	if not $Weapon/HeavyShot2D.is_playing():
		$Weapon/HeavyShot2D.play()
	emit_signal("drone_shoot", Bullet, $Weapon/BulletSpawn.get_global_transform())


func _on_PlayerBulletDetector_area_entered(area):
	$HealhBar.value -= 4
	if $HealhBar.value == 0:
		queue_free()
	
