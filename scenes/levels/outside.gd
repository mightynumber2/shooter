extends LevelParent


func _on_gate_player_entered_gate(_body: Variant) -> void:
	var tween = create_tween()
	tween.tween_property($Player, "speed", 0, 0.8)
	call_deferred("change_scene", "res://scenes/levels/inside.tscn")

func change_scene(scene_path: String) -> void:
	TransitionLayer.change_scene(scene_path)


func _on_house_player_entered() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property($Player/Camera2D, "zoom", Vector2(0.7, 0.7), 1).set_trans(tween.TRANS_QUAD)


func _on_house_player_exited() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property($Player/Camera2D, "zoom", Vector2(0.5, 0.5), 2)
	
