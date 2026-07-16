extends Area2D

@export var platform_path: NodePath
var platform
var activated = false

func _ready():
	platform = get_node(platform_path)

func _on_body_entered(body):
	if body.name == "player" and not activated:
		activated = true
		platform.visible = true
