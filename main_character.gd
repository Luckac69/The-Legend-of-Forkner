extends CharacterBody2D


const SPEED = 300.0
const STOP = .1

@onready var wepon = $Wepon


func _physics_process(delta):

	_movement()
	
	if(Input.is_action_just_pressed("Click")):
		_attack(delta)
	

func _attack(delta):
	wepon.show()
	wepon.rotation = get_angle_to(get_global_mouse_position())+90
	$Wepon/Timer.start()
	wepon.rotate(5*delta)
	



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
	
	
	#FOR Testin 'n stuff
	print(position)
	move_and_slide()
