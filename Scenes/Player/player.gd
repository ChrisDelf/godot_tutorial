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
		can_laser = false
		$LaserCooldown.start()
		laser.emit()
		
	
	# Grenade Tossing input
	if Input.is_action_just_pressed("secondary action") and can_grenade:
		can_grenade = false
		$GrenadeTimer.start()
		grenade.emit()
		


func _on_laser_cooldown_timeout():
	can_laser = true
	


func _on_grenade_timer_timeout():
	can_grenade = true
