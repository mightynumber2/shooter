extends Node2D
class_name LevelParent

var laser_scene: PackedScene = preload("res://scenes/projectiles/laser.tscn")
var grenade_scene: PackedScene = preload("res://scenes/projectiles/grenade.tscn")


func _on_player_laser(pos, direction) -> void:
	var laser = laser_scene.instantiate() as Area2D
	laser.position = pos
	laser.rotation_degrees = rad_to_deg(direction.angle()) + 90
	laser.direction = direction
	$Projectiles.add_child(laser)
	
	
func _on_player_grenade(pos, direction) -> void:
	var grenade = grenade_scene.instantiate() as RigidBody2D
	grenade.position = pos
	grenade.linear_velocity = direction * grenade.SPEED
	$Projectiles.add_child(grenade)


func _on_house_player_entered() -> void:
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	#tween.tween_property($Player, "modulate:a", 0, 1).from(0.5)
	tween.tween_property($Player/Camera2D, "zoom", Vector2(0.7, 0.7), 1).set_trans(tween.TRANS_QUAD)


func _on_house_player_exited() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property($Player/Camera2D, "zoom", Vector2(0.5, 0.5), 2)
