extends Area2D

func _ready():
	$CollisionShape2D.disabled = true

func _on_boss_died():
	$AnimatedSprite2D.play()
	await $AnimatedSprite2D.animation_finished
	$CollisionShape2D.disabled = false	
