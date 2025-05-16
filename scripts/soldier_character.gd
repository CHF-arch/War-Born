extends CharacterBody2D

var movespeed = 1000
var bullet_speed = 3000
var bullet = preload("res://SCENES/bullet.tscn")

var fire_rate = 5.0  
var time_since_last_shot = 0.0
var health := 5
var hearts_list : Array[TextureRect]


func _ready():
	add_to_group("player")
	var hearts_parent = $health_bar/HBoxContainer
	for child in hearts_parent.get_children():
		hearts_list.append(child)
	print(hearts_list)

func _physics_process(delta: float) -> void:
	var input_dir = Input.get_vector("left", "right", "up", "down")
	velocity = input_dir.normalized() * movespeed
	move_and_slide()
	look_at(get_global_mouse_position())
	
	if Input.is_action_pressed("LMB"):
		time_since_last_shot += delta
		
		if time_since_last_shot >= 1.0 / fire_rate:
			fire()
			time_since_last_shot = 0.0

func fire():
	var bullet_instance = bullet.instantiate()
	bullet_instance.damage = 1
	bullet_instance.global_position = global_position
	
	bullet_instance.global_rotation = global_rotation
	var direction = Vector2.RIGHT.rotated(global_rotation)
	bullet_instance.apply_impulse(direction * bullet_speed)
	
	get_tree().root.add_child(bullet_instance)

func take_damage(damage_amount: int) -> void:
	health -= damage_amount
	update_heart_display()
	print("Soldier health:", health)
	if health <= 0:
		die()
		get_tree().reload_current_scene()
		
func die():
	queue_free()
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	print("Enemy collided with:", body.name)
	if body.is_in_group("enemy_bullets"):
		body.queue_free()
		take_damage(body.damage)

func update_heart_display():
	for i in range(hearts_list.size()):
		hearts_list[i].visible = i < health
