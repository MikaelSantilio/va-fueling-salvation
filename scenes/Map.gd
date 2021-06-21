extends Node2D

func _ready():
	pass # Replace with function body.


func _on_Button_pressed():
	get_tree().change_scene("res://scenes/Menu.tscn")


func _on_Button2_pressed():
	get_tree().change_scene("res://scenes/MainScene.tscn")


func _on_Button3_pressed():
	get_tree().change_scene("res://scenes/TestLevel.tscn")
