extends CharacterBody2D


const SPEED = 300.0
const STOP = .1

var health = 100

var isSword = false
var isBow = false
var isSwordSwing = false


var direction : Vector2 = Vector2.ZERO 


@onready var sword = $Sword
@onready var bow = $Bow
@onready var animation = $AnimationPlayer
@onready var animation_tree = $AnimationTree


const bulletPath = preload("res://Code/MainCharacterScripts/bullet.tscn")

func _ready():
	sword.hide()
	bow.hide()
	animation_tree.active = true

func _physics_process(delta):
	# If not dead, then move, else, you are dead
	if(health):
		_movement()
	else:
		direction = Vector2.ZERO
	
	## doing the animations
	update_animation_parameters()
	
	
	## inputs
	if(Input.is_action_just_pressed("sword")):
		if(isSword == false): 
			isSword = true
		else:
			isSword = false
		
	if(Input.is_action_just_pressed("bow")):
		health = 0
		if(isBow == false):
			isBow = true
		else:
			isBow = false
	
	#bow
	if(Input.is_action_just_pressed("Click") && isBow == true):
		_bow(delta)
		
	#sword
	if(Input.is_action_just_pressed("Click") && isSword == true):
		_sword(delta)
	if(isSwordSwing):
		sword.rotate(5*delta)
		
	
	
	
	#print(isSwordSwing)
	#print(animation_tree["parameters/conditions/swing2"])
	#print(animation_tree["parameters/conditions/swing"])
	#print(health)

func _bow(delta):
	bow.rotation = get_angle_to(get_global_mouse_position()) + 45
	bow.show()
	var bullet = bulletPath.instantiate()
	get_parent().add_child(bullet)
	bullet.position = $Bow/Marker2D.global_position 
	
	bullet.velocity = get_local_mouse_position().normalized()
	
	$Bow/Timer.start()

#SWORD stuff
func _sword(delta):
	isSwordSwing = true
	sword.show()
	sword.rotation = get_angle_to(get_global_mouse_position())
	$Sword/SwordTimer.start()
	sword.rotate(5*delta)
	

func _on_timer_timeout():
	sword.hide()
	isSwordSwing = false


func update_animation_parameters():
	
	
	if(health <= 0):
		animation_tree["parameters/conditions/die"] = true
	else:
		animation_tree["parameters/conditions/die"] = false
	
	if(Input.is_action_just_pressed("Click") && isSword):
		animation_tree["parameters/conditions/swing"] = true
	else:
		animation_tree["parameters/conditions/swing"] = false
	
	
	if(velocity == Vector2.ZERO):
		animation_tree["parameters/conditions/is_moving"] = false
		animation_tree["parameters/conditions/idle"] = true
	else:
		animation_tree["parameters/conditions/is_moving"] = true
		animation_tree["parameters/conditions/idle"] = false
	
	animation_tree["parameters/Idle/blend_position"] = direction
	animation_tree["parameters/Walking/blend_position"] = direction
	animation_tree["parameters/SwordSwing/blend_position"] = get_global_mouse_position()
	

func _movement():
	
	direction = Input.get_vector("Left","Right","Up","Down").normalized()
	if direction:
		velocity = direction * SPEED
		if(direction.x>0):
			$Sprite2D.flip_h = false
		if(direction.x<0):
			$Sprite2D.flip_h = true
	else:
		velocity = Vector2(lerp(velocity.x, 0.0, STOP),lerp(velocity.y,0.0,STOP))
	
	####################STOP IF VELOCITY IS TOO LOW
	if velocity.length() < 10:
		velocity = Vector2.ZERO
	
	move_and_slide()

func player():
	pass
