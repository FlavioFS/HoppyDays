extends CanvasLayer

onready var coin_count = $Control/MarginContainer/HBoxContainer/CoinLifeHUD/MarginContainer/HBoxContainer/CoinHUD/CoinCount
onready var life_count = $Control/MarginContainer/HBoxContainer/CoinLifeHUD/MarginContainer/HBoxContainer/LifeHUD/LifeCount

func update_GUI(lives_left, coins):
	life_count.text = str(lives_left)
	coin_count.text = str(coins)


