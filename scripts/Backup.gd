extends Node


	if Input.is_action_just_released("ui_primary_shot"):
		$MiddleShotAudio.stop()
		$EndShotAudio.play()
		$weapon/fire.visible = false
		_start_shot_finished = false
	
	elif !InputEvent("ui_primary_shot").is_echo() and Input.is_action_pressed("ui_primary_shot") and _start_shot_finished:
		$StartShotAudio.stop()
		$weapon/fire.visible = true 
		#emit_signal("shoot", Bullet, get_global_rotation(), get_global_position())
		emit_signal("shoot", Bullet, $BulletSpawn.get_global_transform())
		#emit_signal("create_bullet", global_position)
		
		if not $MiddleShotAudio.is_playing():
			$MiddleShotAudio.play()

	elif Input.is_action_just_pressed("ui_primary_shot"):
		_duration_pressed += delta
		if not $StartShotAudio.is_playing(): 
			$StartShotAudio.play()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
