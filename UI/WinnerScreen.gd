extends Control


onready var scene_tree: = get_tree()
onready var winner_overlay: ColorRect = get_node("WinnerOverlay")


func _ready():
	winner_overlay.visible = false
