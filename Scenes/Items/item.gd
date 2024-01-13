extends Area2D

var rotation_speed: int = 4
var available_options = ['laser','laser','laser','laser', 'health', 'grenade']
var type = available_options[randi()%len(available_options)]

func _process(delta):
	rotation += rotation_speed * delta

func _ready():
	if type == "laser":
		$Sprite2D.modulate = Color(0.1,0.2,0.9)
	if type == "grenade":
		$Sprite2D.modulate = Color(0.8,0.2,0.1)
	if type == "health":
		$Sprite2D.modulate = Color(0.1,0.8,0.1)


func _on_body_entered(_body):
	if type == 'health':
		Globals.health += 10
	if type == "laser":
		Globals.laser_amount += 10
	if type == "grenade":
		Globals.grenade_amount += 3
	
	queue_free()