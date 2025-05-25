extends Area2D

@export var next_scene_path: String = "res://SCENES/right_house_ins.tscn"
var _player_in_range: bool = false

func _ready():
	monitoring = true
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node2D):
	if body.is_in_group("player"):
		_player_in_range = true

func _on_body_exited(body: Node2D):
	if body.is_in_group("player"):
		_player_in_range = false

func _unhandled_input(event: InputEvent):
	if _player_in_range and Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene_to_file(next_scene_path)
