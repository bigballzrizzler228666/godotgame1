extends Area2D

func _on_body_entered(body):
	if body.is_in_group("player"):
		print("Player fell")

		Engine.time_scale = 0.2
		await get_tree().create_timer(0.2).timeout
		Engine.time_scale = 1.0

		get_tree().reload_current_scene()
	
