extends CharacterBody2D

var active: bool = false
var speed: int = 200
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D


func _ready():
	set_physics_process(false)
	call_deferred("physics_setup")

func physics_setup():
	await get_tree().physics_frame
	set_physics_process(true)
	
	
	
func _physics_process(_delta):
	if active:
		var next_path_pos: Vector2 = navigation_agent.get_next_path_position()
		var direction: Vector2 = (next_path_pos - global_position).normalized()
		velocity = direction * speed
		move_and_slide()


func _on_notice_area_body_entered(_body):
	active = true


func _on_notice_area_body_exited(_body):
	active = false


func _on_navigation_timer_timeout():
	if active:
		navigation_agent.target_position = Globals.player_pos
