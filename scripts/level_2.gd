extends Node2D


var entered = false

func _on_porta_aristera_body_entered(body: PhysicsBody2D) -> void:
	entered = true


func _on_porta_aristera_body_exited(body: PhysicsBody2D) -> void:
	entered = false
	
func _process(delta):
	if entered == true:
		if Input.is_action_just_pressed("ui_accept"):
			get_tree().change_scene_to_file("res://SCENES/top_left_building.tscn")
