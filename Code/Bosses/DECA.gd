extends CharacterBody2D


const SPEED = 300.0

var health = 1000



func _physics_process(delta):
	
	update_animation_parameters()
	
	move_and_slide()

func update_animation_parameters():
	pass
