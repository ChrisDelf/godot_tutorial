extends CharacterBody2D

var can_laser: bool = true
var can_grenade: bool = true

func _process(_delta):
	
	#input
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * 500
	#move and slide uses slider already
	move_and_slide()
	
	# laser shooting input
	if Input.is_action_pressed("primary action") and can_laser:
		print("Shoot Laser")
		can_laser = false
	
	# Grenade Tossing input
	if Input.is_action_just_pressed("secondary action") and can_grenade:
		print("Toss grenade")
		can_grenade = false
		
