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
	#print(current_position.y )
	#if current_position.y < -850:
	#	queue_free()


func _on_BulletDamage_area_entered(area):
	print('Acertou')
	queue_free()
