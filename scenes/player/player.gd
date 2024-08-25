extends CharacterBody2D

func _process(_delta: float) -> void:
	# input
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * 500
	move_and_slide()

	# laser shooting input
	if Input.is_action_pressed("primary action"):
		print("shooting mah lazers")
	# shooting grenade input
	if Input.is_action_pressed("secondary action"):
		print("shoot grenade")                    
