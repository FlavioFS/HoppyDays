extends Node2D

var timeout = false

func _process(delta):
	if $Sprite/RayCast2D.is_colliding():
		fire()


func fire():
	if not timeout:
		var lightning = load("res://Scenes/Lightning.tscn").instance()
		$Sprite/RayCast2D.add_child(lightning)
		$Sprite/Timer.start()
		timeout = true


func _on_Timer_timeout():
	timeout = false


