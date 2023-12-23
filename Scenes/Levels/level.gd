extends Node2D

	


func _on_gate_player_entered_gate(body):
	print("Player has entered gate")
	print(body)
	




	


func _on_player_laser():
	print("Laser fired from level")


func _on_player_grenade():
	print("Grenade tossed from level")
