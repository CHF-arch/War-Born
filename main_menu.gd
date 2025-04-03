extends Node2D


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://SCENES/game.tscn")


func _on_info_pressed() -> void:
	get_tree().change_scene_to_file("res://info_menu.tscn")
