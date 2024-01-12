extends LevelParent

func _on_gate_player_entered_gate(_body):
	var tween = create_tween()
	tween.tween_property($Player, "speed",0,0.5)
	#this allows us to move to the next scene
	get_tree().change_scene_to_file("res://Scenes/Levels/inside.tscn")
