extends Area2D

var rotation_speed: int = 4
var available_options = ["laser", "laser", "laser", "laser", "grenade", "health"]
var type = available_options.pick_random()

var direction: Vector2
var distance: int = randi_range(150, 200)
	
func _ready() -> void:
	if type == "laser":
		$Sprite2D.modulate = Color(0.1, 0.2, 0.8)
	if type == "grenade":
		$Sprite2D.modulate = Color(0.8, 0.2, 0.1)
	if type == "health":
		$Sprite2D.modulate = Color(0.1, 0.8, 0.2)
		
# alt tween item out solution
func tween_movement():
	var target_pos = position + direction * distance
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "position", target_pos, 0.5)
	tween.tween_property(self, "scale", Vector2(1, 1), 0.3).from(Vector2(0, 0))
	
func _process(delta: float) -> void:
	rotation += rotation_speed * delta


func _on_body_entered(_body: Node2D) -> void:
	if type == "health":
		Globals.health += 10
	if type == "laser":
		Globals.laser_amount += 5
	if type == "grenade":
		Globals.grenade_amount += 1
	queue_free()
