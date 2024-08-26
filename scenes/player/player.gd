extends CharacterBody2D

signal laser(pos, direction)
signal grenade(pos, direction)

var can_laser: bool = true
var can_grenade: bool = true

func _process(_delta: float) -> void:
	# input
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * 500
	move_and_slide()
	# rotate
	look_at(get_global_mouse_position())
	
	# laser shooting input
	var player_direction = (get_global_mouse_position() - position).normalized()
	if Input.is_action_pressed("primary action") and can_laser:
		$GPUParticles2D.emitting = true
		var laser_markers = $LaserStartPositions.get_children()
		var selected_laser = laser_markers[randi() % laser_markers.size()]
		can_laser = false
		$LaserReloadTimer.start()
		laser.emit(selected_laser.global_position, player_direction)
		
	# shooting grenade input
	if Input.is_action_pressed("secondary action") and can_grenade:
		can_grenade = false      
		$GrenadeReloadTimer.start()
		var pos = $LaserStartPositions.get_children()[0].global_position
		grenade.emit(pos, player_direction)

func _on_laser_reload_timer_timeout() -> void:
	can_laser = true

func _on_grenade_reload_timer_timeout() -> void:
	can_grenade = true
