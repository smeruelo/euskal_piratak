extends Node2D


func _on_boat_boarded(body):
	$Camera._subject = null
	await get_tree().create_timer(4.0).timeout
	get_tree().change_scene_to_file("res://scenes/final_level/final_level.tscn")
