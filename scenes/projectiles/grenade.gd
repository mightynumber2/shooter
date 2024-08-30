extends RigidBody2D

const SPEED = 750
var explosion_active: bool = false
var explosion_radius: int = 350

func explode():
	$AnimationPlayer.play("Explosion")
	explosion_active = true
	
func _process(_delta: float) -> void:
	var targets = get_tree().get_nodes_in_group("Entity") + get_tree().get_nodes_in_group("Container")
	
	if explosion_active:
		for target in targets:
			var in_range = target.global_position.distance_to(global_position) < explosion_radius
			if "hit" in target and in_range:
					target.hit()
			
