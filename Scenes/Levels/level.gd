extends Node2D

# we are preloading a scene make sure you use a file ending in tscn
var laser_scene: PackedScene = preload("res://Scenes/projectiles/laser.tscn")


func _on_gate_player_entered_gate(body):
	print("Player has entered gate")
	print(body)

	

func _on_player_laser(position):
	# we are creating an instance of the node
	var laser = laser_scene.instantiate()
	#update the position of the laser
	laser.position = position
	# now we add laser to the node tree
	$Projectiles.add_child(laser)



func _on_player_grenade():
	print("Grenade tossed from level")
