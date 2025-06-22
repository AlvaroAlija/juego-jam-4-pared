extends Control


func _on_next_level_pressed() -> void:
	GameState.go_to_next_level()


func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://menu.tscn")
