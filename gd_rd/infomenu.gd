extends Node2D


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://SCENES/main_menu.tscn")
	


func _on_back_mouse_entered() -> void:
	$hover.play()
