extends Area2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var ScoreLabel = $"../../CanvasLayer/ScoreLabel"

func _on_body_entered(body: Node2D) -> void:
	ScoreLabel.add_point()
	animation_player.play("pickup")
	queue_free()
