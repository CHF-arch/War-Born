extends Node2D


func _on_start_pressed() -> void:
	$click.play()
	get_tree().change_scene_to_file("res://SCENES/LEVEL1.tscn")
	AudioManager.sfx_XronisIntro.stop()

func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_infooo_pressed() -> void:
	get_tree().change_scene_to_file("res://SCENES/infomenu.tscn")
	

func _on_start_mouse_entered() -> void:
	$hover.play()

func _on_exit_mouse_entered() -> void:
	$hover.play()


func _on_infooo_mouse_entered() -> void:
	$hover.play()
