extends CharacterBody2D

var can_laser: bool = true
var can_grenade: bool = true

@export var max_speed: int = 500
var speed: int = max_speed



#custom signals
signal laser(position, direction)
signal grenade(position, direction)

func _process(_delta):
	
	#input
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	#move and slide uses slider already
	move_and_slide()
	
	# rotate
	look_at(get_global_mouse_position())
	var player_direction = (get_global_mouse_position() - position).normalized()
	# laser shooting input
	if Input.is_action_pressed("primary action") and can_laser and Globals.laser_amount > 0:
		Globals.laser_amount -= 1
		$GPUParticles2D.emitting = true
		$LaserCooldown.start()
		#randomly selected a marker 2d for the laser start
		var laser_markers = $LaserStartPositions.get_children()
		#randi() followed by % then the max size of the list to create a simple randomizer
		var selected_laser = laser_markers[randi() % laser_markers.size()]
		
		can_laser = false
		
		# emit the position when selected
		laser.emit(selected_laser.global_position, player_direction)
		
	
	# Grenade Tossing input
	if Input.is_action_just_pressed("secondary action") and can_grenade and Globals.grenade_amount > 0:
		Globals.grenade_amount -= 1
		$GrenadeTimer.start()
		#for now I'm going to use the laser markers
		var pos_marker = $LaserStartPositions.get_children()[0]
		can_grenade = false
		grenade.emit(pos_marker.global_position, player_direction)
		


func _on_laser_cooldown_timeout():
	can_laser = true
	


func _on_grenade_timer_timeout():
	can_grenade = true
