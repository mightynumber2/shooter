extends LevelParent

@export var outside_level_scene: PackedScene

func _on_exit_gate_area_body_entered(_body: Node2D) -> void:
	var tween = create_tween()
	tween.tween_property($Player, "speed", 0, 0.8)
	get_tree().call_deferred("change_scene_to_packed", outside_level_scene)
