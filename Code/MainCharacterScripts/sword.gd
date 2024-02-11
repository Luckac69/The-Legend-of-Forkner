extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	self.hide() # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotate(10*delta)


func _on_timer_timeout():
	self.hide()
