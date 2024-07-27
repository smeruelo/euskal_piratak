extends Area2D

func _ready():
	$CollisionShape2D.disabled = true

func _on_boss_died():
	$AnimatedSprite2D.play()

func _on_animated_sprite_2d_animation_finished():
	$CollisionShape2D.disabled = false	
