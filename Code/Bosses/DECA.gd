extends CharacterBody2D


const SPEED = 300.0

var health = 1000


var playerInAttackRange = false
var playerAttackCooldown = false


func _physics_process(delta):
	
	update_animation_parameters()
	
	move_and_slide()
	
	print(health)











func update_animation_parameters():
	pass





func _on_hit_box_body_entered(body):
	if body.has_method("player"):
		playerInAttackRange = true


func _on_hit_box_body_exited(body):
	if body.has_method("player"):
		playerInAttackRange = false

func attacked():
	health -= 10

func enemy():
	pass


