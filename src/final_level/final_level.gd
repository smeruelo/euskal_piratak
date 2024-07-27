extends Node2D

func _ready():
	$HUD._init_ui()

func _on_door_body_entered(body):
	get_tree().change_scene_to_file("res://scenes/chest_level/main.tscn")


func _on_player_dead(body):
	$HUD.game_over()

func _on_hud_exit_button_pressed():
	get_tree().quit()

func _on_hud_retry_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")
