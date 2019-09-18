extends AnimatedSprite

func _on_Player_animate(velocity):
	if velocity.y < 0:
		play("jump")
	elif velocity.x > 0:
		play("walk")
		flip_h = false
	elif velocity.x < 0:
		play("walk")
		flip_h = true
	else:
		play("idle")


