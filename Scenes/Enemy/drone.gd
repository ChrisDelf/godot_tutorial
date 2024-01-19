extends CharacterBody2D


var max_speed: int = 600
var speed: int = 0
var speed_multipler: int = 1

var active: bool = false
var vulnerable: bool = true
var health: int = 50


var explosion_active: bool = false
var explosion_radius: int = 400

func explode():
	$AnimationPlayer.play("Explosion")
	explosion_active = true
	
func stop_movement():
	speed_multipler = 0

func _ready():
	$Explosion.hide()
	$DroneImage.show()

func _process(delta):
	if active:
		look_at(Globals.player_pos)
		var direction = (Globals.player_pos - position).normalized()
		velocity = direction * speed * speed_multipler
		var collision = move_and_collide(velocity * delta)
		if collision:
			$DroneImage.material.set_shader_parameter("progress",0.8)
			explode()
	if explosion_active:
		var targets = get_tree().get_nodes_in_group("Container") + get_tree().get_nodes_in_group("Entity")
		for target in targets:
			var in_range = target.global_position.distance_to(global_position) < explosion_radius
			if "hit" in target and in_range:
				target.hit()	
func hit():
	
	if vulnerable:
		health -= 10
		vulnerable = false
		$DroneImage.material.set_shader_parameter("progress",0.8)
		$HitTimer.start()
	
	if health <= 0:
		explode()
		
		
		


func _on_notice_area_body_entered(_body):
	active = true
	var tween = create_tween()
	tween.tween_property(self, "speed", max_speed, 4)





func _on_hit_timer_timeout():
	vulnerable = true
	$DroneImage.material.set_shader_parameter("progress",0)


