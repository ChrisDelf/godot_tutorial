extends LevelParent

func _on_gate_player_entered_gate(_body):
	var tween = create_tween()
	tween.tween_property($Player, "speed",0,0.5)
	#this allows us to move to the next scene
	call_deferred("_deferred_scene_transition")

func _deferred_scene_transition():
	# This function will be called after the current frame is processed
	TransitionLayer.change_scene("res://Scenes/Levels/inside.tscn")


func _on_house_player_entered():
	print("pooper")
	var tween = get_tree().create_tween()
	#zooms in when the character enters the house.
	tween.tween_property($Player/Camera2D, "zoom", Vector2(1,1),1).set_trans(Tween.TRANS_QUAD)


func _on_house_player_leave():
	var tween = get_tree().create_tween()
	#zooms out when the character enters the house.
	tween.tween_property($Player/Camera2D, "zoom", Vector2(.6,.6),1)

