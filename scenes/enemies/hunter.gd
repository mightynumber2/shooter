extends CharacterBody2D

var active: bool = false
var speed: int = 200


func _physics_process(_delta: float) -> void:
	if active:
		var direction: Vector2 = (Globals.player_pos - global_position).normalized()
		velocity = direction * speed
		move_and_slide()
		var look_angle = direction.angle()
		rotation = look_angle + PI / 2
		


func _on_notice_area_body_entered(_body: Node2D) -> void:
	active = true


func _on_notice_area_body_exited(_body: Node2D) -> void:
	active = false
