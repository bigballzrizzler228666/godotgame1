extends Area2D

func _on_body_entered(body):

	print("Something touched potion:", body)

	if body.has_method("unlock_double_jump"):

		# unlock ability
		body.unlock_double_jump()

		# show UI
		var unlock_ui = get_tree().get_first_node_in_group("unlock_ui")

		if unlock_ui:
			unlock_ui.show_unlock(
	"DOUBLE JUMP UNLOCKED",
	"Press Space in air to perform a double jump"
)

		# remove potion
		queue_free()
