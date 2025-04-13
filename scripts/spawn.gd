
extends Node2D

var enemy_scene = preload("res://SCENES/enemy_1.tscn")
var spawn_count: int = 10    
#@export var spawn_radius: float = 100

func _ready():
	spawn_enemies()

func spawn_enemies():
	for i in range(spawn_count):
		var enemy = enemy_scene.instantiate()
		get_parent().add_child(enemy)
		enemy.modulate = Color.RED
		enemy.global_position = Vector2(3196, 2408)
		print("Spawned enemy at: ", enemy.global_position)  
		print("Enemy position: ", global_position, " | Visible: ", is_visible_in_tree())
