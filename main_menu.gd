extends Control

func _on_playbutton_pressed():
	get_tree().change_scene_to_file("res://scenes/game.tscn")



func _on_exit_button_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.
