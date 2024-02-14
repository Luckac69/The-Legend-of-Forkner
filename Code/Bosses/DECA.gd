extends CharacterBody2D


const SPEED = 200.0

var health = 1000

var is_shooting = false
var is_reloading = false 
var DamageCooldown = false

var direction : Vector2 = Vector2.ZERO

#AI variables
@export var ShootingMode = false
@export var ChaseMode = true
@export var ReloadMode = false

@onready var target = get_parent().get_node("MainCharacter")
@onready var animation_tree = $AnimationTree 

func _ready():
	add_to_group("Enemy")

func _physics_process(delta):
	
	update_animation_parameters()
	movement()
	move_and_slide()
	


func movement():
	if(direction):
		velocity = direction.normalized() * SPEED
		if(direction.x>0):
			$Sprite2D.flip_h = false
		if(direction.x<0):
			$Sprite2D.flip_h = true
	else:
		velocity = Vector2.ZERO
	
	calculateDirection()

#AI Stuff
func calculateDirection():
	#print(((position - position.direction_to(target.position)).length()) > 50)
	#print((position-target.position).length() )
	
	
	##Chasing
	if(ChaseMode):
		if (position-target.position).length() < 110:
			ChaseMode = false
			ShootingMode = true
		elif (position-target.position).length() < 100:
			direction =  -position.direction_to(target.position)
		else:
			direction = position.direction_to(target.position)
	
	
	
	##Reload
	#if(ReloadMode):
	#	direction = Vector2.ZERO
	#	is_reloading = true
	#	$reload_time.start()
	
	
	
	##SHOOTING
	if(ShootingMode):
		is_shooting = true
		if (position-target.position).length() < 100:
			direction =  -position.direction_to(target.position)
		elif (position-target.position).length() < 500:
			direction = Vector2.ZERO
		else:
			is_shooting = false
			ShootingMode = false
			ChaseMode = true
		
		if((position - target.position).x<0):
			$Sprite2D.flip_h = false
		if((position - target.position).x>0):
			$Sprite2D.flip_h = true
		
		$shoot_cooldown.start()


func _on_reload_time_timeout():
	ReloadMode = false
	ChaseMode = true
	is_reloading = false

func _on_shoot_cooldown_timeout():
	ShootingMode = false
	is_shooting = false
	ReloadMode = true
	is_reloading = true


func update_animation_parameters():
	
	
	if(health <= 0):
		animation_tree["parameters/conditions/die"] = true
	else:
		animation_tree["parameters/conditions/die"] = false
	
	if is_reloading:
		animation_tree["parameters/conditions/reload"] = true
	else:
		animation_tree["parameters/conditions/reload"] = true
	
	if(is_shooting):
		animation_tree["parameters/conditions/shoot"] = true
	else:
		animation_tree["parameters/conditions/shoot"] = false
	
	
	if(velocity == Vector2.ZERO):
		animation_tree["parameters/conditions/is_moving"] = false
		animation_tree["parameters/conditions/idle"] = true
	else:
		animation_tree["parameters/conditions/is_moving"] = true
		animation_tree["parameters/conditions/idle"] = false
	
	animation_tree["parameters/Idle/blend_position"] = direction
	animation_tree["parameters/Walking/blend_position"] = direction
	animation_tree["parameters/Shooting/blend_position"] = get_global_mouse_position()


func damange(damage):
	health -= damage



func _on_hit_box_area_entered(area):
	if area.has_method("sword"):
		damange(30)
		print(health)


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
