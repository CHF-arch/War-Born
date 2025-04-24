extends CharacterBody2D

@export var speed: float = 100.0
@export var rotation_speed: float = 5.0
@export var bullet_scene = preload("res://SCENES/enemy_bullet.tscn")  

var bullet_speed = 2000
var player: Node2D  
var can_shoot: bool = true
var shoot_cooldown: float = 1.0  
var health := 2

func _ready():
	#add_to_group("player")
	add_to_group("enemies")
	await get_tree().process_frame
	player = get_tree().get_nodes_in_group("player")[0]
	$Area2D.body_entered.connect(_on_body_entered)

func _physics_process(delta):
	if not player:
		return
	
	
	var direction_to_player = (player.global_position - global_position).normalized()
	var target_angle = direction_to_player.angle()
	rotation = lerp_angle(rotation, direction_to_player.angle(), rotation_speed * delta)
	
	
	velocity = direction_to_player * speed
	move_and_slide()
	
	var angle_diff = abs(direction_to_player.angle() - rotation)
	
	if angle_diff < deg_to_rad(90):
		if can_shoot:
			shoot()
			can_shoot = false
			await get_tree().create_timer(shoot_cooldown).timeout
			can_shoot = true

func shoot():
	await get_tree().create_timer(shoot_cooldown).timeout
	if bullet_scene and is_instance_valid(player):
		var bullet = bullet_scene.instantiate()
		var spawn_pos = global_position + Vector2(50, 0).rotated(rotation)
		bullet.global_position = $Muzzle.global_position
		bullet.direction = Vector2.RIGHT.rotated(rotation)
		var direction = Vector2.RIGHT.rotated(global_rotation) + (player.global_position - global_position).normalized()
		bullet.apply_impulse(direction * bullet_speed)
		get_parent().add_child(bullet)
		bullet.modulate = Color.RED
		print("Bullet spawned! Pos: ", bullet.global_position, " Dir: ", bullet.direction)
	
	#if bullet_scene and is_instance_valid(player) and has_node("GunPosition"):
		
		#var bullet = bullet_scene.instantiate()
		#bullet.modulate = Color.RED
		#bullet.global_position = $GunPosition.global_position
		#bullet.direction = (player.global_position - global_position).normalized()
		#var direction = Vector2.RIGHT.rotated(global_rotation)
		#bullet.apply_impulse(direction * bullet_speed)
		#get_tree().current_scene.add_child(bullet)
		#print("Bullet spawned at: ", bullet.global_position)

func take_damage(damage_amount: int) -> void:
	health -= damage_amount
	print("Enemy health:", health)
	if health <= 0:
		die()

func die():
	queue_free()
	

func _on_body_entered(body: Node):
	#print("Enemy collided with:", body.name)
	if body.is_in_group("bullets"):
		body.queue_free()
		take_damage(body.damage)
		
		
