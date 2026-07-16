extends Label

func _ready():
	update_score()

func add_point():
	GameManager.coins += 1
	update_score()

func update_score():
	text = "Coins: " + str(GameManager.coins)
