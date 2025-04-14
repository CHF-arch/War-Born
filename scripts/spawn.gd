extends Node2D


@onready var enemy_scene = preload("res://SCENES/enemy_1.tscn")
var spawn_count: int = 10

func _ready() -> void:
	await get_tree().create_timer(1).timeout
	for i in range(spawn_count):
		spawn_enemies()
		await get_tree().create_timer(1).timeout

func spawn_enemies():
	var enemy = enemy_scene.instantiate()
	enemy.position = position
	get_parent().add_child(enemy)
	add_child(enemy)
	print("Spawned enemy at: ", enemy.global_position)
	print("Enemy position: ", enemy.global_position, " | Visible: ", enemy.is_visible_in_tree())
