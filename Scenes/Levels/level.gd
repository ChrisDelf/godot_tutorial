extends Node2D

# we are preloading a scene make sure you use a file ending in tscn
var laser_scene: PackedScene = preload("res://Scenes/projectiles/laser.tscn")
var grenade_scene: PackedScene = preload("res://Scenes/projectiles/grenade.tscn")



func _on_gate_player_entered_gate(body):
	print("Player has entered gate")
	print(body)

	

func _on_player_laser(position, direction):
	# we are creating an instance of the node
	var laser = laser_scene.instantiate() as Area2D
	#update the position of the laser
	laser.position = position
	laser.rotation_degrees  = rad_to_deg(direction.angle()) + 90
	laser.direction = direction
	
	# now we add laser to the node tree
	$Projectiles.add_child(laser)
	



func _on_player_grenade(position, direction):
	var grenade = grenade_scene.instantiate() as RigidBody2D
	grenade.position = position
	grenade.linear_velocity = direction * grenade.speed
	$Projectiles.add_child(grenade)
	
	
