extends CharacterBody2D

@export var speed: float = 100.0
@export var rotation_speed: float = 5.0
@export var bullet_scene: PackedScene  # Η σκηνή της σφαίρας (αν χρειάζεται)

var player: Node2D  # Θα αναφέρεται στον παίκτη
var can_shoot: bool = true
var shoot_cooldown: float = 1.0  # Πόσο συχνά πυροβολεί

func _ready():
	# Βρες τον παίκτη αυτόματα (πρέπει να έχει τη δική του σκηνή)
	player = get_tree().get_nodes_in_group("player")[0]

func _physics_process(delta):
	if not player:
		return
	
	# Περιστροφή προς τον παίκτη
	var direction_to_player = (player.global_position - global_position).normalized()
	var target_angle = direction_to_player.angle()
	rotation = lerp_angle(rotation, target_angle, rotation_speed * delta)
	
	# Κίνηση προς τον παίκτη (προαιρετικό)
	velocity = direction_to_player * speed
	move_and_slide()
	
	# Έλεγχος αν ο παίκτης είναι ορατός (με RayCast)
	$RayCast2D.target_position = direction_to_player * 500  # Απόσταση ελέγχου
	$RayCast2D.force_raycast_update()
	
	if $RayCast2D.is_colliding() and $RayCast2D.get_collider() == player:
		if can_shoot:
			shoot()
			can_shoot = false
			await get_tree().create_timer(shoot_cooldown).timeout
			can_shoot = true

func shoot():
	if bullet_scene:
		var bullet = bullet_scene.instantiate()
		bullet.global_position = global_position
		bullet.direction = (player.global_position - global_position).normalized()
		get_parent().add_child(bullet)
