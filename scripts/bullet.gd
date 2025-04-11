extends RigidBody2D

var speed = 800
var direction = Vector2()
var damage = 1

func _ready():
	body_entered.connect(_on_body_entered)
	await get_tree().create_timer(2.0).timeout
	queue_free()
	print("Bullet layers:", collision_layer, " | masks:", collision_mask)


func _physics_process(delta):
	position += direction * speed * delta

func _on_body_entered(body):
	print("Σύγκρουση με:", body.name)
	if body.is_in_group("enemies"):
		print("Εχθρός χτυπήθηκε!")
		body.take_damage()
	queue_free()
