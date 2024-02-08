extends CharacterBody2D


const SPEED = 300.0
const STOP = .1

var isSword = false
var isBow = false

@onready var sword = $Sword
@onready var bow = $Bow

const bulletPath = preload("res://bullet.tscn")

func _physics_process(delta):
	_movement()
	
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



func _movement():
	# Horizantal
	var xdirection = Input.get_axis("Left", "Right")
	if xdirection:
		velocity.x = xdirection * SPEED
	else:
		velocity.x = lerp(velocity.x, 0.0, STOP)
	
	# Virtical
	var ydirection = Input.get_axis("Up", "Down")
	if ydirection:
		velocity.y = ydirection * SPEED
	else:
		velocity.y = lerp(velocity.y, 0.0, STOP)
	
	print(position)
	move_and_slide()
