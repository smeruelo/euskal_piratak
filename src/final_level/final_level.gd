extends Node2D


func _on_door_body_entered(body):
	get_tree().change_scene_to_file("res://scenes/main.tscn")
