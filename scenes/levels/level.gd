extends Node2D

var test_array: Array[String] = ["Test", "Hello", "stuff"]
	
func test_function():
	print("this is a test function")


func _on_area_2d_body_entered(_body: Node2D) -> void:
	print("body has entered")


func _on_area_2d_body_exited(_body: Node2D) -> void:
	print("body has exited")
