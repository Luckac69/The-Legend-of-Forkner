extends Control

func _on_exit_button_button_down():
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
