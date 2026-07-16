extends Node2D

const SPEED = 60
var direction = 1
var hp = 3

@onready var ray_right = $RayCastRight
@onready var ray_left = $RayCastLeft
@onready var sprite = $AnimatedSprite2D


func _process(delta):

	# flip logic
	if ray_right.is_colliding():
		direction = -1
		sprite.flip_h = true

	elif ray_left.is_colliding():
		direction = 1
		sprite.flip_h = false

	position.x += direction * SPEED * delta
