extends CharacterBody2D


const SPEED = 300.0
const STOP = .1

var isSword = false
var isBow = false

@onready var sword = $Sword
@onready var bow = $Bow
@onready var animation = $AnimationPlayer
@onready var animation_tree = $AnimationTree


const bulletPath = preload("res://Code/MainCharacterScripts/bullet.tscn")

func _ready():
	animation_tree.active = true

func _physics_process(delta):
	_movement()
	
	update_animation_parameters()
	
	if(Input.is_action_just_pressed("sword")):
		if(isSword == false): 
			isSword = true
		else:
			isSword = false
		
	if(Input.is_action_just_pressed("bow")):
		if(isBow == false):
			isBow = true
		else:
			isBow = false
	
	if(Input.is_action_just_pressed("Click") && isSword == true):
		_sword(delta)
	
	if(Input.is_action_just_pressed("Click") && isBow == true):
		_bow(delta)


#####MOVE TO BOW OBJECT
func _bow(delta):
	bow.rotation = get_angle_to(get_global_mouse_position()) + 45
	bow.show()
	var bullet = bulletPath.instantiate()
	get_parent().add_child(bullet)
	bullet.position = $Bow/Marker2D.global_position 
	
	bullet.velocity = get_local_mouse_position().normalized()
	
	$Bow/Timer.start()

func _sword(delta):
	sword.show()
	sword.rotation = get_angle_to(get_global_mouse_position())+90
	$Sword/Timer.start()
	sword.rotate(5*delta)

func update_animation_parameters():
	if(velocity == Vector2.ZERO):
		animation_tree["parameters/conditions/is_moving"] = false
		animation_tree["parameters/conditions/idle"] = true
	else:
		animation_tree["parameters/conditions/is_moving"] = true
		animation_tree["parameters/conditions/idle"] = false
	
	if(Input.is_action_just_pressed("Click")):
		animation_tree["parameters/conditions/swing"] = true
	else:
		animation_tree["parameters/conditions/swing"] = false
	

func _movement():
	# Horizantal
	var xdirection = Input.get_axis("Left", "Right")
	if xdirection:
		velocity.x = xdirection * SPEED
		if(xdirection>0):
			$Sprite2D.flip_h = false
		if(xdirection<0):
			$Sprite2D.flip_h = true
	else:
		velocity.x = lerp(velocity.x, 0.0, STOP)
	
	# Virtical
	var ydirection = Input.get_axis("Up", "Down")
	if ydirection:
		velocity.y = ydirection * SPEED
	else:
		velocity.y = lerp(velocity.y, 0.0, STOP)
	
	print(velocity)
	move_and_slide()
