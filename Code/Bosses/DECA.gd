extends CharacterBody2D


const SPEED = 300.0

var health = 1000


var DamageCooldown = false


func _physics_process(delta):
	
	update_animation_parameters()
	
	move_and_slide()
	



func update_animation_parameters():
	pass


func deal_with_damange(damage):
	health -= damage



func _on_hit_box_area_entered(area):
	if area.has_method("sword"):
		deal_with_damange(30)
		print("enter")


func attacked():
	if DamageCooldown:
		DamageCooldown = false
		health -= 10
		$attack_cooldown.start()
		print(health)

func _on_attack_cooldown_timeout():
	DamageCooldown = true


func enemy():
	pass








