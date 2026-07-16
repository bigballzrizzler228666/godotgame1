extends Area2D

@export var message: String = "SANDS OF TIME"
@export var display_time: float = 5.0

var triggered: bool = false

func _on_body_entered(body):

	if triggered:
		return

	if body.name == "player":
		triggered = true

		var unlock_ui = get_tree().get_first_node_in_group("unlock_ui")

		if unlock_ui:
			unlock_ui.show_unlock(
				message,
				"",
				display_time
			)
