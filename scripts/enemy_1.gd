extends CharacterBody2D

@export var speed: float = 100.0
@export var rotation_speed: float = 5.0
@export var bullet_scene: PackedScene  

var player: Node2D  
var can_shoot: bool = true
var shoot_cooldown: float = 1.0  
var health := 2

func _ready():
	await get_tree().process_frame
	add_to_group("player")
	player = get_tree().get_nodes_in_group("player")[0]
	add_to_group("enemies")
	$Area2D.body_entered.connect(_on_body_entered)

func _physics_process(delta):
	if not player:
		return
	
	
	var direction_to_player = (player.global_position - global_position).normalized()
	var target_angle = direction_to_player.angle()
	rotation = lerp_angle(rotation, target_angle, rotation_speed * delta)
	
	
	velocity = direction_to_player * speed
	move_and_slide()
	
	
	$RayCast2D.target_position = direction_to_player * 500
	$RayCast2D.force_raycast_update()
	
	if $RayCast2D.is_colliding() and $RayCast2D.get_collider() == player:
		if can_shoot:
			shoot()
			can_shoot = false
			await get_tree().create_timer(shoot_cooldown).timeout
			can_shoot = true

func shoot():
	if bullet_scene and is_instance_valid(player):
		var bullet = bullet_scene.instantiate()
		bullet.global_position = $GunPosition.global_position
		bullet.direction = (player.global_position - global_position).normalized()
		get_parent().add_child(bullet)
		print("Bullet spawned!")

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
		
		
