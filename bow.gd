extends Node2D



# Called when the node enters the scene tree for the first time.
func _ready():
	self.hide() # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.rotation = get_angle_to(get_global_mouse_position())



