extends Button
@onready var button = $Button
@onready var timer = $Timer


func _on_pressed() -> void:
	get_tree().change_scene_to_file("res://SCENES/LOAD_SCREEN_AFTER_PROLOGUE.tscn")
	
