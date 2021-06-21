extends Node2D

var speed = 15000
var rng = RandomNumberGenerator.new()
var current_position

func _ready():
	rng.randomize()

func _process(delta):
	speed = rng.randf_range(6000, 14000)
	position += transform.x * speed * delta
	current_position = get_global_position()
	
	if current_position.y > 570 or current_position.y < -8000 or current_position.x < 3000 or current_position.x > 85000:
		queue_free()
