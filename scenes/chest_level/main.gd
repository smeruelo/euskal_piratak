extends Node

signal finished

func _ready():
	$Player.is_animated = true

func _on_chest_body_entered(body):
	if body.name != "Player":
		return
	$Chest/AnimatedSprite2D.play()
	await $Chest/AnimatedSprite2D.animation_finished
	$Label.visible = true
	await get_tree().create_timer(5.0).timeout
	get_tree().change_scene_to_file("res://scenes/start.tscn")
