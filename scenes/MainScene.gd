extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var HUD = load("res://UI/HUD.tscn").instance()

func _ready():
	# Set HUD
	add_child(HUD)
	# Set Camera Limits
	var camera = $car/Camera2D
	camera.limit_bottom = 670
	camera.limit_left = 6
	camera.limit_right = 20200

	# Set Menu
	var PauseInterface = load("res://UI/PauseInterface.tscn").instance()
	add_child(PauseInterface)
	Global.level_id = get_instance_id()


func _on_car_shoot_car(bullet, shoot_transform):
	var b = bullet.instance()
	add_child(b)
	b.set_global_transform(shoot_transform)
	Global.player_bullets -= 1

func _on_Drone_drone_shoot(bullet, shoot_transform):
	var b = bullet.instance()
	add_child(b)
	b.set_global_transform(shoot_transform)


func _on_Drone3_drone_shoot(bullet, shoot_transform):
	var b = bullet.instance()
	add_child(b)
	b.set_global_transform(shoot_transform)


func _on_Drone2_drone_shoot(bullet, shoot_transform):
	var b = bullet.instance()
	add_child(b)
	b.set_global_transform(shoot_transform)
