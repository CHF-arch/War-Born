extends CharacterBody2D

var movespeed = 800
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	var input_dir = Input.get_vector("left", "right", "up", "down")
	velocity = input_dir.normalized() * movespeed
	move_and_slide()
	look_at(get_global_mouse_position())
	
	
