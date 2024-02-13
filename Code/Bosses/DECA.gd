extends CharacterBody2D


const SPEED = 200.0

var health = 1000

var is_shooting = false
var DamageCooldown = false

var direction : Vector2 = Vector2.ZERO

@onready var target = get_parent().get_node("main_character")
@onready var animation_tree = $AnimationTree 

func _ready():
	add_to_group("Enemy")

func _physics_process(delta):
	
	update_animation_parameters()
	movement()
	move_and_slide()
	


func movement():
	if(direction):
		velocity = direction * SPEED
		if(direction.x>0):
			$Sprite2D.flip_h = false
		if(direction.x<0):
			$Sprite2D.flip_h = true
	else:
		velocity = Vector2.ZERO
	
	calculateDirection()

func calculateDirection():
	print(((position - position.direction_to(get_parent().get_node("MainCharacter").position)).length()) > 50)
	if((position - position.direction_to(get_parent().get_node("MainCharacter").position)).length()) > 50 or true:
		direction = position.direction_to(get_parent().get_node("MainCharacter").position)
	else: pass


func update_animation_parameters():
	
	if(health <= 0):
		animation_tree["parameters/conditions/die"] = true
	else:
		animation_tree["parameters/conditions/die"] = false
	
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








