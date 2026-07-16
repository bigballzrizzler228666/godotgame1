extends HBoxContainer

@onready var hearts = [$Heart1, $Heart2, $Heart3]

@export var full_heart: Texture2D
@export var empty_heart: Texture2D

func update_hearts(hp):
	for i in range(hearts.size()):
		if i < hp:
			hearts[i].texture = full_heart
		else:
			hearts[i].texture = empty_heart
