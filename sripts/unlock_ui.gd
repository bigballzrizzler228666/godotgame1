extends Control

@onready var bg = $ColorRect
@onready var label = $Label
@onready var sub_label = $SubLabel

func _ready():
	visible = false


func show_unlock(text: String, sub_text: String = "", hold_time: float = 4.0):

	visible = true

	label.text = text
	sub_label.text = sub_text

	bg.modulate.a = 0.0
	label.modulate.a = 0.0
	sub_label.modulate.a = 0.0

	var tween = create_tween()

	# FADE IN
	tween.tween_property(bg, "modulate:a", 0.6, 0.5)
	tween.parallel().tween_property(label, "modulate:a", 1.0, 0.5)
	tween.parallel().tween_property(sub_label, "modulate:a", 1.0, 0.5)

	await get_tree().create_timer(hold_time).timeout

	# FADE OUT
	var tween2 = create_tween()

	tween2.tween_property(bg, "modulate:a", 0.0, 1.0)
	tween2.parallel().tween_property(label, "modulate:a", 0.0, 1.0)
	tween2.parallel().tween_property(sub_label, "modulate:a", 0.0, 1.0)

	await tween2.finished

	visible = false
