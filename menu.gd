extends Control


func _on_play_pressed() -> void:
	GameState.go_to_next_level()
