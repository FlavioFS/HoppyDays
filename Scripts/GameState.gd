extends Node2D

const COIN_TARGET = 3
var coins = 0

func _ready():
#	if Input.is_action_just_pressed("toggle_fullscreen"):
#		OS.window_fullscreen = !OS.window_fullscreen
	add_to_group("Gamestate")
	update_GUI()


func hurt():
	$Player.hurt()
	update_GUI()
	if $Player.lives < 1:
		end_game()


func update_GUI():
	get_tree().call_group("GUI", "update_GUI", $Player.lives, coins)


func coin_up():
	coins += 1
	update_GUI()
	var coin_multiple = (coins % COIN_TARGET) == 0
	if coin_multiple:
		life_up()


func life_up():
	$Player.lives += 1
	update_GUI()


func end_game():
	get_tree().change_scene("res://Scenes/GameOver.tscn")


func win_game():
	get_tree().change_scene("res://Scenes/Victory.tscn")
 







