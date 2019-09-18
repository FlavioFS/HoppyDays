extends Node2D

var taken = false

func _ready():
	if not $AnimatedSprite.is_playing():
		$AnimatedSprite.play("spin")


func _on_Area2D_body_entered(body):
	if not taken:
		taken = true
		$AnimationPlayer.play("die")
		$SFX.play()
		get_tree().call_group("Gamestate", "coin_up")


func die():
	queue_free()



