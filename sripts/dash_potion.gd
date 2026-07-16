extends Area2D

func _on_body_entered(body):

	if body.has_method("unlock_dash"):

		# unlock ability
		body.unlock_dash()

		# show nice UI popup (your system)
		var unlock_ui = get_tree().get_first_node_in_group("unlock_ui")

		if unlock_ui:
			unlock_ui.show_unlock(
				"DASH UNLOCKED",
				"Press Mouse Wheel to dash on ground or air"
			)

		queue_free()
