
extends Node2D

var enemy_scene = preload("res://SCENES/enemy_1.tscn")
@export var spawn_count: int = 10    
@export var spawn_radius: float = 100  

func _ready():
	spawn_enemies()

func spawn_enemies():
	var plane_exit_position = Vector2(-500, 500)  # Συντεταγμένες εξόδου αεροπλάνου
	for i in range(spawn_count):
		var enemy = enemy_scene.instantiate()
		enemy.global_position = plane_exit_position  # Ίδια θέση για όλους
		get_parent().add_child(enemy)
		print("Spawned enemy at: ", enemy.global_position)  # Debug
