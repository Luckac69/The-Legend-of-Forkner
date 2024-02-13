extends Control

func _on_back_button_button_up():
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")


func _on_full_screen_toggled(toggled_on):
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func _on_borderless_toggled(toggle_on):
	DisplayServer.window_get_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, toggle_on)

func _on_v_sync_item_selected(index):
	DisplayServer.window_set_vsync_mode(index)
