extends Control

const PATH_SCENE = "res://Scenes/Level1.tscn"

func _on_Button_pressed():
	get_tree().change_scene(PATH_SCENE)


func _on_QuitButton_pressed():
	get_tree().quit()

