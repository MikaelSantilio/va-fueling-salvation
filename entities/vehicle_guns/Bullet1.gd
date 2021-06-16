extends Node2D

var speed = 2000
var velocity = Vector2(500,500)

func _process(delta):
	#position.x += speed * delta
	position += transform.x * speed * delta
	# position += velocity * delta
	#position.y += speed * delta
	#position += velocity * delta
