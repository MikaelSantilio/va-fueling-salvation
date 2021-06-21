extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var HUD = load("res://UI/HUD.tscn").instance()

# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(HUD)


func _on_car_shoot_car(bullet, shoot_transform):
	var b = bullet.instance()
	add_child(b)
	b.set_global_transform(shoot_transform)
	Global.player_bullets -= 1

func _on_Drone_drone_shoot(bullet, shoot_transform):
	var b = bullet.instance()
	add_child(b)
	b.set_global_transform(shoot_transform)


func _on_Drone2_drone_shoot(bullet, shoot_transform):
	var b = bullet.instance()
	add_child(b)
	b.set_global_transform(shoot_transform)
