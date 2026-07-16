extends Area2D

var player_in_range = false
var label = null

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		player_in_range = true

		label = body.get_node_or_null("InteractLabel")
		if label:
			label.visible = true

func _on_body_exited(body: Node2D) -> void:
	if body.name == "player":
		player_in_range = false

		var lbl = body.get_node_or_null("InteractLabel")
		if lbl:
			lbl.visible = false

		label = null

func _process(delta: float) -> void:
	if player_in_range and Input.is_action_just_pressed("interact"):
		get_tree().change_scene_to_file("res://Scenes/Shop.tscn")
