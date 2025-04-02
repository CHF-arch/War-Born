extends CharacterBody2D

var movespeed = 1000
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var bullet_speed = 3000
var bullet = preload("res://SCENES/bullet.tscn")


var fire_rate = 5.0  
var time_since_last_shot = 0.0

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
	
	var muzzle_offset = Vector2(50, 0).rotated(global_rotation)
	bullet_instance.global_position = global_position + muzzle_offset
	
	bullet_instance.global_rotation = global_rotation
	var direction = Vector2.RIGHT.rotated(global_rotation)
	bullet_instance.apply_impulse(direction * bullet_speed)
	
	get_tree().root.add_child(bullet_instance)
	print("Bullet at: ", bullet_instance.global_position, " | Player at: ", global_position)
