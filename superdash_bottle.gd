extends Area2D

func _on_body_entered(body):
	if body.has_method("unlock_super_dash"):
		body.unlock_super_dash()
		var unlock_ui = get_tree().get_first_node_in_group("unlock_ui")

		if unlock_ui:
			unlock_ui.show_unlock(
				"SUPERDASH UNLOCKED",
				"Hold E for 3 seconds and release to perform superdash."
			)
		queue_free()
