extends Node2D

const SPEED = 600

func _ready():
	set_as_toplevel(true)
	global_position = get_parent().global_position


func _process(delta):
	position.y += SPEED * delta
	manage_collision()


func manage_collision():
	var colliders = $Area2D.get_overlapping_bodies()
	for body in colliders:
		if body.name == "Player":
			get_tree().call_group("Gamestate", "hurt")
		queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()



