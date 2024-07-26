extends CanvasLayer

@onready var health_bar = $health_bar/TextureProgressBar
@onready var stamina_bar = $stamina_bar/TextureProgressBar

func increase_health(amount):
	health_bar.value = min(health_bar.value + amount, 100)
	
func increase_stamina(amount):
	stamina_bar.value = min(stamina_bar.value + amount, 100)

func get_health():
	return health_bar.value

func get_stamina():
	return stamina_bar.value
