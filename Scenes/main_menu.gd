extends Control

func _on_start_button_button_up():
	get_tree().change_scene_to_file("res://Scenes/world.tscn")
	
func _on_options_button_button_up():
	get_tree().change_scene_to_file("res://Scenes/options_menu.tscn")

func _on_lore_button_button_up():
	get_tree().change_scene_to_file("res://Scenes/story_menu.tscn")

func _on_credit_button_button_up():
	get_tree().change_scene_to_file("res://Scenes/credits_menu.tscn")






#exit
func _on_button_button_up():
	get_tree().quit()
