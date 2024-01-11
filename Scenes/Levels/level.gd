extends Node2D
class_name LevelParent

# we are preloading a scene make sure you use a file ending in tscn
var laser_scene: PackedScene = preload("res://Scenes/projectiles/laser.tscn")
var grenade_scene: PackedScene = preload("res://Scenes/projectiles/grenade.tscn")

func _on_gate_player_entered_gate(_body):
	var tween = create_tween()
	tween.tween_property($Player, "speed",0,0.5)
	get_tree().change_scene_to_file("res://Scenes/Levels/inside.tscn")



	

func _on_player_laser(position1, direction):
	# we are creating an instance of the node
	var laser = laser_scene.instantiate() as Area2D
	#update the position of the laser
	laser.position = position1
	laser.rotation_degrees  = rad_to_deg(direction.angle()) + 90
	laser.direction = direction
	
	# now we add laser to the node tree
	$Projectiles.add_child(laser)
	$UI.update_laser_text()



func _on_player_grenade(position1, direction):
	var grenade = grenade_scene.instantiate() as RigidBody2D
	grenade.position = position1
	grenade.linear_velocity = direction * grenade.speed
	$Projectiles.add_child(grenade)
	$UI.update_grenade_text()
	


func _on_house_player_entered(_body):
	var tween = get_tree().create_tween()
	#zooms in when the character enters the house.
	tween.set_parallel(true)
	tween.tween_property($Player/Camera2D, "zoom", Vector2(1,1),1).set_trans(Tween.TRANS_QUAD)
	#tween.tween_property($Player, "modulate:a",0,2).from(0.5)


func _on_house_player_leave(_body):
	var tween = get_tree().create_tween()
	#zooms out when the character enters the house.
	tween.tween_property($Player/Camera2D, "zoom", Vector2(.6,.6),1)
