extends CharacterBody2D

var vulnerable: bool = true
var health: int = 20
var speed: int = 300

var player_nearby: bool = false
var can_attack: bool = false


func hit():
	if vulnerable:
		health -= 10
		vulnerable = false
		$Timers/HitTimer.start()
		$AnimatedAttack.material.set_shader_parameter("progress", 1)
		$Particles/HitParticles.emitting = true
	if health <=0:
		await get_tree().create_timer(0.5).timeout
		queue_free()
		

func _process(_delta: float) -> void:
	var direction: Vector2 = (Globals.player_pos - position).normalized()
	velocity = direction * speed
	if player_nearby:
		look_at(Globals.player_pos)
		move_and_slide()
		
func _on_notice_area_2d_body_entered(_body: Node2D) -> void:
	player_nearby = true
	$AnimatedWalk.play("walk")

func _on_notice_area_2d_body_exited(_body: Node2D) -> void:
	player_nearby = false
	$AnimatedWalk.stop()


func _on_attack_area_2d_body_entered(_body: Node2D) -> void:
	can_attack = true
	$AnimatedAttack.play("attack")

func _on_attack_area_2d_body_exited(_body: Node2D) -> void:
	can_attack = false
	$AnimatedAttack.stop()


func _on_animated_attack_animation_finished() -> void:
	if can_attack:
		Globals.health -= 10
		$Timers/AttackTimer.start()
		

func _on_hit_timer_timeout() -> void:
	vulnerable = true
	$AnimatedAttack.material.set_shader_parameter("progress", 0)
	$Particles/HitParticles.emitting = false
	
func _on_attack_timer_timeout() -> void:
	$AnimatedAttack.play("attack")
