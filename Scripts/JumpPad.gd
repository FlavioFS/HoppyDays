extends Area2D

func _ready():
	if not $AnimatedSprite.is_playing():
		$AnimatedSprite.play("idle")


func _on_JumpPad_body_entered(body):
	if body.has_method("boost"):
		$AnimationPlayer.play("boost")
		body.boost()




