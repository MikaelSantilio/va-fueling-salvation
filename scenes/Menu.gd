extends Node2D

func _ready():
	pass




func _on_StartGameButton_pressed():
	get_tree().change_scene("res://scenes/Map.tscn")



func _on_AboutButton_pressed():
	get_tree().change_scene("res://scenes/About.tscn")


func _on_ExitButton_pressed():
	get_tree().quit() # Replace with function body.
