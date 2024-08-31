extends CharacterBody2D

var active: bool = false
var speed: int = 0
var max_speed: int = 600

var vulnerable: bool = true
var health: int = 50

var explosion_active: bool = false
var explosion_radius: int = 350

func _ready() -> void:
	$Explosion.hide()
	$Sprite2D.show()

func _process(delta: float) -> void:
	if active:
		look_at(Globals.player_pos)
		var direction = (Globals.player_pos - position).normalized()
		velocity = direction * speed
		var collision = move_and_collide(velocity * delta)
		if collision:
			$AnimationPlayer.play("explosion")
			explosion_active = true
			active = false
			
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
		$HitTimer.start()
		$Sprite2D.material.set_shader_parameter("progress", 1)
	if health <= 0:
		$AnimationPlayer.play("explosion")
		explosion_active = true
		active = false
		
		
func _on_notice_area_body_entered(_body: Node2D) -> void:
	if not explosion_active:
		active = true
		var tween = create_tween()
		tween.tween_property(self, "speed", max_speed, 6)


func _on_hit_timer_timeout() -> void:
	vulnerable = true
	$Sprite2D.material.set_shader_parameter("progress", 0)
