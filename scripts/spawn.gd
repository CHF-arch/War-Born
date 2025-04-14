extends Node2D


@onready var enemy_scene = preload("res://SCENES/enemy_1.tscn")
var spawn_count: int = 10
@export var spawn_radius: float = 100

func spawn_enemies():
	var enemy = enemy_scene.instantiate()
	enemy.position = position
	get_parent().add_child(enemy)
	add_child(enemy)

func _on_timer_timeout() -> void:
	spawn_enemies()
