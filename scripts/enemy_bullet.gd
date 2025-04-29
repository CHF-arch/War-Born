extends RigidBody2D

var speed = 800
var direction = Vector2()
var damage = 1

func _ready():
	add_to_group("enemy_bullets")
	await get_tree().create_timer(0.6).timeout
	queue_free()

func _physics_process(delta):
	position += direction * speed * delta

func _on_body_entered(body):
	if body.is_in_group("player"):
		body.take_damage(damage) 
		queue_free() 
