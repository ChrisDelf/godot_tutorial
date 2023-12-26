extends CharacterBody2D

var can_laser: bool = true
var can_grenade: bool = true

#custom signals
signal laser
signal grenade

func _process(_delta):
	
	#input
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * 500
	#move and slide uses slider already
	move_and_slide()
	
	# laser shooting input
	if Input.is_action_pressed("primary action") and can_laser:
		#randomly selected a marker 2d for the laser start
		var laser_markers = $LaserStartPositions.get_children()
		#randi() followed by % then the max size of the list to create a simple randomizer
		var selected_laser = laser_markers[randi() % laser_markers.size()]
		can_laser = false
		$LaserCooldown.start()
		# emit the position when selected
		laser.emit(selected_laser.global_position)
		
	
	# Grenade Tossing input
	if Input.is_action_just_pressed("secondary action") and can_grenade:
		can_grenade = false
		$GrenadeTimer.start()
		grenade.emit()
		


func _on_laser_cooldown_timeout():
	can_laser = true
	


func _on_grenade_timer_timeout():
	can_grenade = true
