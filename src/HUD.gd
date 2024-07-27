extends CanvasLayer

@onready var health_bar = $health_bar/TextureProgressBar
@onready var stamina_bar = $stamina_bar/TextureProgressBar
@onready var game_over_menu = $Game_Over/VBoxContainer

signal exit_button_pressed
signal retry_button_pressed

func _init_ui():
	game_over_menu.visible = false
	
func increase_health(amount):
	health_bar.value = min(health_bar.value + amount, 100)
	
func increase_stamina(amount):
	stamina_bar.value = min(stamina_bar.value + amount, 100)

func get_health():
	return health_bar.value

func get_stamina():
	return stamina_bar.value

func _on_exit_button_pressed():
	exit_button_pressed.emit()

func _on_retry_button_pressed():
	retry_button_pressed.emit()
