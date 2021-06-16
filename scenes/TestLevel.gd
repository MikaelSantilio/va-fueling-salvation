extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_car_shoot_car(bullet, shoot_transform):
	var b = bullet.instance()
	add_child(b)
	b.set_global_transform(shoot_transform)
