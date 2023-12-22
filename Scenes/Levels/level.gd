extends Node2D



# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass

	
	
	#print(Input.is_action_just_pressed("left"))

func test_function():
	pass


func _on_area_2d_body_entered(_body):
	print("Body has entered")


func _on_area_2d_body_exited(_body):
	print("Body has left")
	
