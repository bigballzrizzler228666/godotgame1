extends Area2D

var player_inside := false

func _on_body_entered(body: Node2D) -> void:
	print("Entered:", body.name)
	if body.name == "player":
		player_inside = true
		print("Player is inside the exit door.")

func _on_body_exited(body: Node2D) -> void:
	print("Exited:", body.name)
	if body.name == "player":
		player_inside = false

func _process(_delta: float) -> void:
	if player_inside and Input.is_action_just_pressed("interact"):
		print("Loading game...")
		get_tree().change_scene_to_file("res://game.tscn")
