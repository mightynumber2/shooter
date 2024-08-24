extends Node2D

func _process(delta: float) -> void:
	# input
	var direction = Input.get_vector("left", "right", "up", "down")
	position += direction * 500 * delta

	# laser shooting input
	if Input.is_action_pressed("primary action"):
		print("shooting mah lazers")
	# shooting grendae input
	if Input.is_action_pressed("secondary action"):
		print("shoot grenade")                    
