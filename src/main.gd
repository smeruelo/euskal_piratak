extends Node2D

@onready var game_over_menu : Control = $HUD/Game_Over/VBoxContainer
@onready var player = $Player
@onready var hud = $HUD

func _ready():
	init_game()

func init_game():
	hud._init_ui()
	player.init()
		
func game_over():
	game_over_menu.visible = true

func _on_boat_boarded(body):
	$Camera._subject = null
	await get_tree().create_timer(4.0).timeout
	get_tree().change_scene_to_file("res://scenes/final_level/final_level.tscn")


func _on_player_dead(_player):
	game_over()

func _on_hud_exit_button_pressed():
	game_over_menu.visible = false
	get_tree().quit()

func _on_hud_retry_button_pressed():
	get_tree().reload_current_scene()
