extends Node2D


var entered = false




func _process(delta):
	if entered == true:
		if Input.is_action_just_pressed("ui_accept"):
			get_tree().change_scene_to_file("res://SCENES/level_2.tscn")
