extends CharacterBody2D

var active: bool = false
var player_near: bool = false
var vulnerable: bool = true
var health: int = 100
var speed: int = 200
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D


func _ready():
	$NavigationAgent2D.path_desired_distance = 4.0
	$NavigationAgent2D.target_desired_distance = 4.0
	$NavigationAgent2D.target_position = Globals.player_pos
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
		var look_angle = direction.angle()
		rotation = look_angle + PI / 2


func _on_notice_area_body_entered(_body):
	active = true
	$AnimationPlayer.play("walk")


func _on_notice_area_body_exited(_body):
	active = false


func _on_navigation_timer_timeout():
	if active:
		navigation_agent.target_position = Globals.player_pos


func _on_attack_area_body_entered(_body):
	player_near = true
	$AnimationPlayer.play("attack")
	


func _on_attack_area_body_exited(_body):
	player_near = false
	
func attack():
	if player_near:
		Globals.health -= 20

func hit():
	if vulnerable:
		health -= 10
		$Time/HitTimer.start()
		vulnerable = false
	if health <= 0:
		queue_free()
		
func _on_hit_timer_timeout():
	vulnerable = true
