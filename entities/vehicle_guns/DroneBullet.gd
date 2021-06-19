extends Node2D

var speed = 15000
var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()

func _process(delta):
	speed = rng.randf_range(6000, 14000)
	position += transform.x * speed * delta
