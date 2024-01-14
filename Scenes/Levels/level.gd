extends Node2D
class_name LevelParent

# we are preloading a scene make sure you use a file ending in tscn
var laser_scene: PackedScene = preload("res://Scenes/projectiles/laser.tscn")
var grenade_scene: PackedScene = preload("res://Scenes/projectiles/grenade.tscn")
var item_scene: PackedScene = preload("res://Scenes/Items/item.tscn")

func _ready():
	for container in get_tree().get_nodes_in_group("Container"):
		container.connect("open", _on_container_opened)
	for scout in get_tree().get_nodes_in_group('Scouts'):
		scout.connect('laser', _on_scout_laser)
		
func _on_container_opened(pos, direction):
	var item = item_scene.instantiate()
	item.position = pos
	item.direction = direction
	$Items.call_deferred('add_child', item)
	
	

func _on_gate_player_entered_gate(_body):
	var tween = create_tween()
	tween.tween_property($Player, "speed",0,0.5)
	get_tree().change_scene_to_file("res://Scenes/Levels/inside.tscn")



	

func _on_player_laser(pos, direction):
	create_laser(pos, direction)

func _on_scout_laser(pos, direction):
	create_laser(pos, direction)
	
func create_laser(pos, direction):
		# we are creating an instance of the node
	var laser = laser_scene.instantiate() as Area2D
	#update the position of the laser
	laser.position = pos
	laser.rotation_degrees  = rad_to_deg(direction.angle()) + 90
	laser.direction = direction
	
	# now we add laser to the node tree
	$Projectiles.add_child(laser)

func _on_player_grenade(position1, direction):
	var grenade = grenade_scene.instantiate() as RigidBody2D
	grenade.position = position1
	grenade.linear_velocity = direction * grenade.speed
	$Projectiles.add_child(grenade)

	





