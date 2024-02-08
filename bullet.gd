extends CharacterBody2D


#var veliocity = Vector2(0,0)
var speed = 10000

func _physics_process(delta):
	var collision_info = move_and_collide(velocity.normalized() * delta* speed)
