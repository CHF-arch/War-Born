extends Area2D

@export var next_scene_path: String = "res://SCENES/level_2.tscn"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_body_entered(body: Node2D) -> void:
	if body.name == ("player"):
		var tween = create_tween()
		
		tween.tween_property(self, "position", position + Vector2(0, -20), 0.3)
		tween.tween_property(self, "modulate:a", 0.0, 0.3)
		
		queue_free()
		get_tree().change_scene_to_file(next_scene_path)
