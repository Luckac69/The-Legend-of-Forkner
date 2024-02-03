extends CharacterBody2D


const SPEED = 300.0
const STOP = .1


func _physics_process(delta):
	

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	
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

	move_and_slide()
