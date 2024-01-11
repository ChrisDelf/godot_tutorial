extends LevelParent

func _on_gate_player_entered_gate(_body):
	var tween = create_tween()
	tween.tween_property($Player, "speed",0,0.5)
	#this allows us to move to the next scene
	call_deferred("_deferred_scene_transition")

func _deferred_scene_transition():
	# This function will be called after the current frame is processed
	TransitionLayer.change_scene("res://Scenes/Levels/inside.tscn")
