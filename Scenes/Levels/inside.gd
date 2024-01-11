extends LevelParent

#@export var outside_level_scene: PackedScene

func _on_exit_gate_area_body_entered(_body):
	var tween = create_tween()
	tween.tween_property($Player, "speed",0,0.5)
	#get_tree().change_scene_to_file("res://Scenes/Levels/outside.tscn")
	#get_tree().change_scene_to_packed(outside_level_scene)
	call_deferred("_deferred_scene_transition")

func _deferred_scene_transition():
	# This function will be called after the current frame is processed
	TransitionLayer.change_scene("res://Scenes/Levels/outside.tscn")
